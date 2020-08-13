require 'rails_helper'

RSpec.describe Purchaser, type: :model do
  describe 'validations' do
    subject { create(:purchaser) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
