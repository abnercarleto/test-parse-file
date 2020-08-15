require 'rails_helper'
require 'csv'

RSpec.describe SalesImporter::PurchaserImporter, type: :business do
  include_context 'Parser Context'

  let(:import_item) { class_spy('ImportItem') }
  let(:sale_import) { create(:sale_import) }

  describe '.call' do
    subject(:import_call) do
      described_class.call(sale_import,
                           purchaser_name,
                           [importer_row],
                           import_item: import_item)
    end

    before do
      allow(import_item).to receive(:call) do |sale, _row|
        create(:item, sale: sale)
      end
    end

    context 'when puchaser not exists' do
      it do
        expect { import_call }.to change { Purchaser.count }.by(1).
                                  and change { Sale.count }.by(1)
      end

      it 'should create a purchaser with sale' do
        sale = import_call
        expect(sale).to be_persisted
        expect(sale.purchaser).to be_persisted
        expect(sale.purchaser.name).to eq purchaser_name
        expect(sale.sale_import).to eq sale_import
      end

      it 'should call import_item' do
        import_call
        expect(import_item).to have_received(:call) do |sale, row|
          expect(sale).to be_a(Sale).and be_persisted
          expect(row).to be_a(SalesImporter::Row)
        end
      end
    end

    context 'when puchaser exists' do
      before { create(:purchaser, name: purchaser_name) }

      it do
        expect { import_call }.to change { Purchaser.count }.by(0).
                                  and change { Sale.count }.by(1)
      end

      it 'should call import_item' do
        import_call
        expect(import_item).to have_received(:call) do |sale, row|
          expect(sale).to be_a(Sale).and be_persisted
          expect(row).to be_a(SalesImporter::Row)
        end
      end
    end

    context 'when puchaser exists with some sale' do
      before do
        create(:purchaser, name: purchaser_name).
          sales.
          create!(sale_import: sale_import)
      end

      it do
        expect { import_call }.to change { Purchaser.count }.by(0).
                                  and change { Sale.count }.by(1)
      end

      it 'should call import_item' do
        import_call
        expect(import_item).to have_received(:call) do |sale, row|
          expect(sale).to be_a(Sale).and be_persisted
          expect(row).to be_a(SalesImporter::Row)
        end
      end
    end
  end
end