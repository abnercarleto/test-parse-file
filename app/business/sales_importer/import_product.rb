module SalesImporter
  class ImportProduct
    class << self
      def call(*args, **kwargs)
        new(*args, **kwargs).call
      end
    end

    def initialize(row, import_merchant: ImportMerchant)
      @row = row
      @import_merchant = import_merchant
    end

    def call
      Product.find_or_create_by!(description: row.item_description,
                                 merchant: import_merchant.call(row))
    end

    private

    attr_reader :row, :import_merchant
  end
end