module SalesImporter
  class Row
    ColSpec = Struct.new(:header, :col_index)

    COLUMNS = {
      purchaser_name: ColSpec.new('purchaser name', 0).freeze,
      item_description: ColSpec.new('item description', 1).freeze,
      item_price: ColSpec.new('item price', 2).freeze,
      purchase_count: ColSpec.new('purchase count', 3).freeze,
      merchant_address: ColSpec.new('merchant address', 4).freeze,
      merchant_name: ColSpec.new('merchant name', 5).freeze
    }.freeze

    def initialize(csv_row)
      @csv_row = csv_row
    end

    COLUMNS.keys.each do |method_name|
      define_method(method_name) do
        col_spec = COLUMNS[method_name]
        @csv_row[col_spec.header].presence || @csv_row[col_spec.col_index]
      end
    end

    def ==(other)
      other.is_a?(self.class) &&
        self.purchaser_name == other.purchaser_name &&
        self.item_description == other.item_description &&
        self.item_price == other.item_price &&
        self.purchase_count == other.purchase_count &&
        self.merchant_address == other.merchant_address &&
        self.merchant_name == other.merchant_name
    end
  end
end