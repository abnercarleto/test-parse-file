require 'rails_helper'
require 'csv'

RSpec.describe SalesImporter::Row, type: :business do
  subject(:importer_row) { described_class.new(row) }

  describe '#purchaser_name' do
    let(:purchaser_name) { Faker::Name.name }

    subject { importer_row.purchaser_name }

    context 'when have a valid header name' do
      let(:row) do
        CSV::Row.new(
          [nil, 'purchaser name'],
          [nil, purchaser_name]
        )
      end

      it { is_expected.to eq purchaser_name }
    end

    context 'when have a invalid header name' do
      let(:row) do
        CSV::Row.new(
          ['invalid name'],
          [purchaser_name]
        )
      end

      it { is_expected.to eq purchaser_name }
    end
  end

  describe '#item_description' do
    let(:item_description) { Faker::Commerce.product_name }

    subject { importer_row.item_description }

    context 'when have a valid header name' do
      let(:row) do
        CSV::Row.new(
          ['item description'],
          [item_description]
        )
      end

      it { is_expected.to eq item_description }
    end

    context 'when have a invalid header name' do
      let(:row) do
        CSV::Row.new(
          [nil, 'invalid name'],
          [nil, item_description]
        )
      end

      it { is_expected.to eq item_description }
    end
  end

  describe '#item_price' do
    let(:item_price) { Faker::Commerce.price }

    subject { importer_row.item_price }

    context 'when have a valid header name' do
      let(:row) do
        CSV::Row.new(
          ['item price'],
          [item_price]
        )
      end

      it { is_expected.to eq item_price }
    end

    context 'when have a invalid header name' do
      let(:row) do
        CSV::Row.new(
          [nil, nil, 'invalid name'],
          [nil, nil, item_price]
        )
      end

      it { is_expected.to eq item_price }
    end
  end

  describe '#purchase_count' do
    let(:purchase_count) { SecureRandom.rand(1..30) }

    subject { importer_row.purchase_count }

    context 'when have a valid header name' do
      let(:row) do
        CSV::Row.new(
          ['purchase count'],
          [purchase_count]
        )
      end

      it { is_expected.to eq purchase_count }
    end

    context 'when have a invalid header name' do
      let(:row) do
        CSV::Row.new(
          [nil, nil, nil, 'invalid name'],
          [nil, nil, nil, purchase_count]
        )
      end

      it { is_expected.to eq purchase_count }
    end
  end

  describe '#merchant_address' do
    let(:merchant_address) { Faker::Address.full_address }

    subject { importer_row.merchant_address }

    context 'when have a valid header name' do
      let(:row) do
        CSV::Row.new(
          ['merchant address'],
          [merchant_address]
        )
      end

      it { is_expected.to eq merchant_address }
    end

    context 'when have a invalid header name' do
      let(:row) do
        CSV::Row.new(
          [nil, nil, nil, nil, 'invalid name'],
          [nil, nil, nil, nil, merchant_address]
        )
      end

      it { is_expected.to eq merchant_address }
    end
  end

  describe '#merchant_name' do
    let(:merchant_name) { Faker::Company.name }

    subject { importer_row.merchant_name }

    context 'when have a valid header name' do
      let(:row) do
        CSV::Row.new(
          ['merchant name'],
          [merchant_name]
        )
      end

      it { is_expected.to eq merchant_name }
    end

    context 'when have a invalid header name' do
      let(:row) do
        CSV::Row.new(
          [nil, nil, nil, nil, nil, 'invalid name'],
          [nil, nil, nil, nil, nil, merchant_name]
        )
      end

      it { is_expected.to eq merchant_name }
    end
  end
end