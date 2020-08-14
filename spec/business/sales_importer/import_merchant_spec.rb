require 'rails_helper'
require 'csv'

RSpec.describe SalesImporter::ImportMerchant, type: :business do
  include_context 'Parser Context'

  describe '.call' do
    subject(:import_call) do
      described_class.call(importer_row)
    end

    context 'when merchant not exists' do
      it { expect { import_call }.to change { Merchant.count }.by(1) }

      it 'should create a merchant' do
        merchant = import_call
        expect(merchant).to be_persisted
        expect(merchant.name).to eq merchant_name
        expect(merchant.address).to eq merchant_address
      end
    end

    context 'when merchant exists' do
      before do
        create(:merchant, name: merchant_name, address: merchant_address)
      end

      it { expect { import_call }.to change { Merchant.count }.by(0) }
    end

    context 'when exist merchant with same name' do
      before { create(:merchant, name: merchant_name) }

      it { expect { import_call }.to change { Merchant.count }.by(1) }

      it 'should create a merchant' do
        merchant = import_call
        expect(merchant).to be_persisted
        expect(merchant.name).to eq merchant_name
        expect(merchant.address).to eq merchant_address
      end
    end

    context 'when exist merchant with same address' do
      before { create(:merchant, address: merchant_address) }

      it { expect { import_call }.to change { Merchant.count }.by(1) }

      it 'should create a merchant' do
        merchant = import_call
        expect(merchant).to be_persisted
        expect(merchant.name).to eq merchant_name
        expect(merchant.address).to eq merchant_address
      end
    end
  end
end