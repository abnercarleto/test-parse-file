require 'rails_helper'
require 'csv'

RSpec.describe SalesImporter::Parser, type: :business do
  let(:purchaser_name) { Faker::Name.name }
  let(:item_description) { Faker::Commerce.product_name }
  let(:item_price) { Faker::Commerce.price }
  let(:purchase_count) { SecureRandom.rand(1..30) }
  let(:merchant_address) { Faker::Address.full_address }
  let(:merchant_name) { Faker::Company.name }
  let(:file_header_array) do
    ['purchaser name', 'item description', 'item price', 'purchase count',
     'merchant address', 'merchant name']
  end
  let(:file_header) { file_header_array.join("\t") }
  let(:file_row_array) do
    [purchaser_name, item_description, item_price, purchase_count,
     merchant_address, merchant_name]
  end
  let(:file_row) { file_row_array.join("\t") }
  let(:file_content) { [file_header, file_row].join("\n") }
  let(:csv_row) { CSV::Row.new(file_header_array, file_row_array) }
  let(:importer_row) { SalesImporter::Row.new(csv_row) }

  describe '.call' do
    subject { described_class.call(file_content) }

    it { is_expected.to eq [importer_row] }
  end

  describe '#call' do
    subject { described_class.new(file_content).call }

    it { is_expected.to eq [importer_row] }
  end
end