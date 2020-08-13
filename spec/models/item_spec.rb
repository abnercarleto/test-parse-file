require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:sale).required }
    it { is_expected.to belong_to(:product).required }
  end

  describe 'validations' do
    subject { create(:item) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:count) }
    it { is_expected.to validate_uniqueness_of(:product_id).scoped_to(:sale_id) }
  end
end
