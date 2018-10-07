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
end
