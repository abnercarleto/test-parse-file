require 'rails_helper'
require 'csv'

RSpec.describe SalesImporter::PurchaserImporter, type: :business do
  include_context 'Parser Context'

  describe '.call' do
    subject(:import_call) do
      described_class.call(purchaser_name, [importer_row])
    end

    context 'when puchaser not exists' do
      it do
        expect { import_call }.to change { Purchaser.count }.by(1).
                                  and change { Sale.count }.by(1)
      end

      it 'should create a purchaser with sale' do
        puchaser = import_call
        expect(puchaser).to be_persisted
        expect(puchaser.sales.last).to be_persisted
        expect(puchaser.name).to eq purchaser_name
      end
    end

    context 'when puchaser exists' do
      before { create(:purchaser, name: purchaser_name) }

      it do
        expect { import_call }.to change { Purchaser.count }.by(0).
                                  and change { Sale.count }.by(1)
      end
    end

    context 'when puchaser exists with some sale' do
      before { create(:purchaser, name: purchaser_name).sales.create! }

      it do
        expect { import_call }.to change { Purchaser.count }.by(0).
                                  and change { Sale.count }.by(1)
      end
    end
  end
end