require 'rails_helper'

RSpec.describe Sale, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:purchaser).required }
    it { is_expected.to belong_to(:sale_import).required }
    it { is_expected.to have_many(:items) }
  end
end
