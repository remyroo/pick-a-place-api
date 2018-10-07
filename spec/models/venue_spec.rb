require 'rails_helper'

RSpec.describe Venue, type: :model do
  context 'validations' do
    subject(:venue) { FactoryBot.build(:venue) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:opening_hours) }
    it { is_expected.to validate_presence_of(:website_url) }
  end
end
