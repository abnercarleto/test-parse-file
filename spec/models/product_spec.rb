require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:merchant).required }
  end

  describe 'validations' do
    subject { create(:product) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_uniqueness_of(:description).scoped_to(:merchant_id) }
  end
end
