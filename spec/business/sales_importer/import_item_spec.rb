require 'rails_helper'
require 'csv'

RSpec.describe SalesImporter::ImportItem, type: :business do
  include_context 'Parser Context'

  let(:import_product) { class_spy('ImportProduct') }
  let(:product) { create(:product) }
  let(:sale) { create(:sale) }

  describe '.call' do
    subject(:import_call) do
      described_class.call(sale, importer_row, import_product: import_product)
    end

    before do
      allow(import_product).to receive(:call).and_return(product)
    end

    context 'when item not exists' do
      it { expect { import_call }.to change { Item.count }.by(1) }

      it 'should create a item' do
        item = import_call
        expect(item).to be_persisted
        expect(item.sale).to eq sale
        expect(item.product).to eq product
        expect(item.price).to eq item_price.to_d
        expect(item.count).to eq purchase_count
      end
    end

    context 'when item exists' do
      before { create(:item) }

      it { expect { import_call }.to change { Item.count }.by(1) }

      it 'should create a item' do
        item = import_call
        expect(item).to be_persisted
        expect(item.sale).to eq sale
        expect(item.product).to eq product
        expect(item.price).to eq item_price.to_d
        expect(item.count).to eq purchase_count
      end
    end

    context 'when item exists with same product' do
      before { create(:item, product: product) }

      it { expect { import_call }.to change { Item.count }.by(1) }

      it 'should create a item' do
        item = import_call
        expect(item).to be_persisted
        expect(item.sale).to eq sale
        expect(item.product).to eq product
        expect(item.price).to eq item_price.to_d
        expect(item.count).to eq purchase_count
      end
    end

    context 'when item exists with same sale' do
      before { create(:item, sale: sale) }

      it { expect { import_call }.to change { Item.count }.by(1) }

      it 'should create a item' do
        item = import_call
        expect(item).to be_persisted
        expect(item.sale).to eq sale
        expect(item.product).to eq product
        expect(item.price).to eq item_price.to_d
        expect(item.count).to eq purchase_count
      end
    end

    context 'when item exists with same product and sale' do
      before { create(:item, product: product, sale: sale) }

      it { expect { import_call }.to change { Item.count }.by(0) }

      it 'should create a item' do
        item = import_call
        expect(item).to be_persisted
        expect(item.sale).to eq sale
        expect(item.product).to eq product
        expect(item.price).to eq item_price.to_d
        expect(item.count).to eq purchase_count
      end
    end
  end
end