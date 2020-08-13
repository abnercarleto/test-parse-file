require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    subject { create(:merchant) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_uniqueness_of(:address).scoped_to(:name) }
  end
end
