# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Neighbourhood, type: :model do
  context 'validations' do
    subject(:neighbourhood) { FactoryBot.build(:neighbourhood) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to validate_presence_of(:radius) }
  end

  context 'has many venues' do
    let(:venue_1) { FactoryBot.create(:venue) }
    let(:venue_2) { FactoryBot.create(:venue) }
    let(:neighbourhood) { FactoryBot.create(:neighbourhood) }

    before do
      venue_1.update(neighbourhood: neighbourhood)
      venue_2.update(neighbourhood: neighbourhood)
    end

    it 'returns the multiple jobs' do
      expect(neighbourhood.venues).to include venue_1, venue_2
    end
  end
end
