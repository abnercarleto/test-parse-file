require 'rails_helper'
require 'csv'

RSpec.describe SalesImporter::Importer, type: :business do
  include_context 'Parser Context'

  let(:parser) { class_spy('Parser', 'parser') }
  let(:group_importer) { class_spy('PurchaserImporter') }
  let(:file_content) { Faker::Lorem.paragraph }

  describe '.call' do
    subject(:import_call) do
      described_class.call(file_content, parser: parser,
                                         group_importer: group_importer)
    end

    context 'when have two purchasers' do
      before do
        allow(parser).to receive(:call).and_return([importer_row, importer_row_2])
        import_call
      end

      it { expect(parser).to have_received(:call).with(file_content) }
      it 'should group_importer receive two groups of purchasers' do
        expect(group_importer).to have_received(:call).twice do |sale_import, name, group|
          expect(sale_import).to be_a SaleImport
          expect(name).to be_a String
          expect(group).to be_a Array
        end
      end
    end

    context 'when have one purchaser and two items' do
      before do
        allow(parser).to receive(:call).and_return([importer_row, importer_row])
        import_call
      end

      it { expect(parser).to have_received(:call).with(file_content) }
      it 'should group_importer receive two groups of purchasers' do
        expect(group_importer).to have_received(:call) do |sale_import, name, group|
          expect(sale_import).to be_a SaleImport
          expect(name).to be_a String
          expect(group).to be_a Array
        end
      end
    end

  end
end