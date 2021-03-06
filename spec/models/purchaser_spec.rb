require 'rails_helper'

RSpec.describe Purchaser, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:sales) }
  end

  describe 'validations' do
    subject { create(:purchaser) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
