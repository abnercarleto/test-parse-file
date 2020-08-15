require 'rails_helper'

RSpec.describe SaleImport, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:sales) }
  end
end
