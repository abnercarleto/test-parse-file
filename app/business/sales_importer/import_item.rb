module SalesImporter
  class ImportItem
    class << self
      def call(*args, **kwargs)
        new(*args, **kwargs).call
      end
    end

    def initialize(sale, row, import_product: ImportProduct)
      @sale = sale
      @row = row
      @import_product = import_product
    end

    def call
      Item.find_or_initialize_by(sale: sale,
                                  product: import_product.call(row)).
           tap do |item|
             item.assign_attributes(price: row.item_price,
                                    count: row.purchase_count)
             item.save!
           end
    end

    private

    attr_reader :sale, :row, :import_product
  end
end