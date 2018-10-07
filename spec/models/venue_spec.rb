# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Venue, type: :model do
  context 'validations' do
    subject(:venue) { FactoryBot.build(:venue) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:opening_hours) }
    it { is_expected.to validate_presence_of(:website_url) }
  end

  context 'belongs to a neighbourhood' do
    let(:neighbourhood) { FactoryBot.create(:neighbourhood) }
    let(:venue) { FactoryBot.create(:venue, neighbourhood: neighbourhood) }

    it 'returns the neighbourhood' do
      expect(venue.neighbourhood).to eq neighbourhood
    end
  end
end
