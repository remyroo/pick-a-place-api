require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    subject(:user) { FactoryBot.build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }

    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:username).case_insensitive }

    it { should allow_values('_user', '2user', 'use').for(:username) }
    it { should_not allow_values('-', '/user', 'User', 'us', '16pluscharstoolong').for(:username) }
  end
end
