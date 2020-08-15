require 'rails_helper'
require 'csv'

RSpec.describe SalesImporter::ImportProduct, type: :business do
  include_context 'Parser Context'

  let(:import_merchant) { class_spy('ImportMerchant') }
  let(:merchant) { create(:merchant) }

  describe '.call' do
    subject(:import_call) do
      described_class.call(importer_row, import_merchant: import_merchant)
    end

    before do
      allow(import_merchant).to receive(:call).and_return(merchant)
    end

    context 'when product not exists' do
      it { expect { import_call }.to change { Product.count }.by(1) }

      it 'should create a product' do
        product = import_call
        expect(product).to be_persisted
        expect(product.description).to eq item_description
        expect(product.merchant).to eq merchant
      end

      it 'should call import_merchant' do
        import_call
        expect(import_merchant).to have_received(:call) do |row|
          expect(row).to be_a(SalesImporter::Row)
        end
      end
    end

    context 'when product exists' do
      before do
        create(:product, description: item_description, merchant: merchant)
      end

      it { expect { import_call }.to change { Product.count }.by(0) }

      it 'should call import_merchant' do
        import_call
        expect(import_merchant).to have_received(:call) do |row|
          expect(row).to be_a(SalesImporter::Row)
        end
      end
    end

    context 'when product exists with same description' do
      before { create(:product, description: item_description) }

      it { expect { import_call }.to change { Product.count }.by(1) }

      it 'should create a product' do
        product = import_call
        expect(product).to be_persisted
        expect(product.description).to eq item_description
        expect(product.merchant).to eq merchant
      end

      it 'should call import_merchant' do
        import_call
        expect(import_merchant).to have_received(:call) do |row|
          expect(row).to be_a(SalesImporter::Row)
        end
      end
    end

    context 'when product exists with same merchant' do
      before { create(:product, merchant: merchant) }

      it { expect { import_call }.to change { Product.count }.by(1) }

      it 'should create a product' do
        product = import_call
        expect(product).to be_persisted
        expect(product.description).to eq item_description
        expect(product.merchant).to eq merchant
      end

      it 'should call import_merchant' do
        import_call
        expect(import_merchant).to have_received(:call) do |row|
          expect(row).to be_a(SalesImporter::Row)
        end
      end
    end
  end
end