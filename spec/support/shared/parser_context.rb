RSpec.shared_context 'Parser Context' do
  let(:purchaser_name) { Faker::Name.name }
  let(:purchaser_name_2) { Faker::Name.name }
  let(:item_description) { Faker::Commerce.product_name }
  let(:item_description_2) { Faker::Commerce.product_name }
  let(:item_price) { Faker::Commerce.price }
  let(:item_price_2) { Faker::Commerce.price }
  let(:purchase_count) { SecureRandom.rand(1..30) }
  let(:purchase_count_2) { SecureRandom.rand(1..30) }
  let(:merchant_address) { Faker::Address.full_address }
  let(:merchant_address_2) { Faker::Address.full_address }
  let(:merchant_name) { Faker::Company.name }
  let(:merchant_name_2) { Faker::Company.name }
  let(:file_header_array) do
    ['purchaser name', 'item description', 'item price', 'purchase count',
     'merchant address', 'merchant name']
  end
  let(:file_header) { file_header_array.join("\t") }
  let(:file_row_array) do
    [purchaser_name, item_description, item_price, purchase_count,
     merchant_address, merchant_name]
  end
  let(:file_row_array_2) do
    [purchaser_name_2, item_description_2, item_price_2, purchase_count_2,
     merchant_address_2, merchant_name_2]
  end
  let(:file_row) { file_row_array.join("\t") }
  let(:file_row_2) { file_row_array_2.join("\t") }
  let(:file_content) { [file_header, file_row].join("\n") }
  let(:csv_row) { CSV::Row.new(file_header_array, file_row_array) }
  let(:csv_row_2) { CSV::Row.new(file_header_array, file_row_array_2) }
  let(:importer_row) { SalesImporter::Row.new(csv_row) }
  let(:importer_row_2) { SalesImporter::Row.new(csv_row_2) }
end