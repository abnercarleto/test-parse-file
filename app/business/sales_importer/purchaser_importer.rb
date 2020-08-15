module SalesImporter
  class PurchaserImporter
    class << self
      def call(*args)
        new(*args).call
      end
    end

    def initialize(sale_import, purchaser_name, group, import_item: ImportItem)
      @sale_import = sale_import
      @purchaser_name = purchaser_name
      @group = group
      @import_item = import_item
    end

    def call
      create_sale.
        tap do |sale|
          group.each { |row| sale.items << import_item.call(sale, row) }
        end
    end

    private

    attr_reader :sale_import, :purchaser_name, :group, :import_item

    def purchaser
      Purchaser.find_or_create_by!(name: purchaser_name)
    end

    def create_sale
      purchaser.sales.create!(sale_import: sale_import)
    end
  end
end