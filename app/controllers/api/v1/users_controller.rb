module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user, except: [:create]
      before_action :authorize_as_admin, only: [:index]
      before_action :authorize, only: [:update, :destroy]

      def index
        users = User.all
        json_response(users, :ok)
      end

      def create
        user = User.create!(user_params)
        auth_token = Knock::AuthToken.new(payload: { sub: user.id }).token
        response = { user: user, auth_token: auth_token }
        json_response(response, :created)
      end

      def update
        current_user.update!(user_params)
        json_response(current_user, :ok)
      end

      def destroy
        current_user.destroy
        head :no_content
      end
    end
  end
end

private

def user_params
  params.require(:user).permit(:username, :email, :password, :password_confirmation)
end

def authorize
  raise ExceptionHandler::AuthorizationError unless current_user.present? && current_user.can_modify_user?(params[:id])
end
