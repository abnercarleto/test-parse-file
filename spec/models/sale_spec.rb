require 'rails_helper'

RSpec.describe Sale, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:purchaser).required }
  end
end
