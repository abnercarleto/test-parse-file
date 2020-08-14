module SalesImporter
  class ImportMerchant
    class << self
      def call(*args)
        new(*args).call
      end
    end

    def initialize(row)
      @row = row
    end

    def call
      Merchant.find_or_create_by!(name: row.merchant_name,
                                  address: row.merchant_address)
    end

    private

    attr_reader :row
  end
end