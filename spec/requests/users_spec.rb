require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin) }
  let!(:valid_params) do {
    user:
      {
        email: Faker::Internet.email,
        username: Faker::Internet.username(3..15),
        password: 'password',
        password_confirmation: 'password'
      }
  } end
  let!(:invalid_params) do {
    user:
      {
        email: user.email,
        username: user.username,
        password: 'password',
        password_confirmation: 'password'
      }
  } end

  describe 'POST #create' do
    context 'on success' do
      before { post api_signup_path, params: valid_params, headers: {} }

      it 'creates a new user' do
        expect(response).to have_http_status(:created)
        expect(json['user']['email']).to eq(valid_params[:user][:email])
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'on failure' do
      before { post api_signup_path, params: invalid_params, headers: {} }

      it 'does not create a user' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a failure message' do
        expect(json['message'])
          .to match(
            /Validation failed: Email has already been taken, Username has already been taken/
          )
      end
    end
  end

  describe 'GET #index' do
    context 'on success' do
      it 'returns all users for admin user' do
        get api_users_path, headers: authenticated_header(admin)
        expect(json.count).to eq(2)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'on failure' do
      before do
        get api_users_path, headers: authenticated_header(user)
      end

      it 'raises unauthorized error for non-admin user' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns a failure message' do
        expect(json['message'])
          .to match(
            /Unauthorized Request/
          )
      end
    end
  end

  describe 'PUT #update' do
    context 'on success' do
      it 'allows user to update their own data' do
        put api_user_path(user.id),
            params: { user: {username: 'new_username'} },
            headers: authenticated_header(user)

        expect(json['username']).to eq('new_username')
        expect(response).to have_http_status(:ok)
      end

      it 'allows admin to update any user data' do
        put api_user_path(user.id),
            params: { user: {email: 'new_email@me.com'} },
            headers: authenticated_header(admin)

        expect(json['email']).to eq('new_email@me.com')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'on failure' do
      before do
        put api_user_path(admin.id),
            params: { user: {username: 'new_username'} },
            headers: authenticated_header(user)
      end

      it 'raises error for unauthorized updates' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns a failure message' do
        expect(json['message'])
          .to match(
            /Unauthorized Request/
          )
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:users) { create_pair(:user) }

    context 'on success' do
      it 'allows user to delete their own data' do
        delete api_user_path(users.first.id),
               headers: authenticated_header(users.first)
        expect(response).to have_http_status(:no_content)
      end

      it 'allows admin to delete users data' do
        delete api_user_path(users.second.id),
               headers: authenticated_header(admin)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'on failure' do
      before do
        delete api_user_path(admin.id),
               headers: authenticated_header(user)
      end

      it 'raises error for unauthorized deletes' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns a failure message' do
        expect(json['message'])
          .to match(
            /Unauthorized Request/
          )
      end
    end
  end
end
