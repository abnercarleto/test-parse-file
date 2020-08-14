module SalesImporter
  class PurchaserImporter
    class << self
      def call(*args)
        new(*args).call
      end
    end

    def initialize(purchaser_name, group)
      @purchaser_name = purchaser_name
      @group = group
    end

    def call
      create_sale
      purchaser
    end

    private

    attr_reader :purchaser_name, :group

    def purchaser
      @purchaser ||= Purchaser.find_or_create_by!(name: purchaser_name)
    end

    def create_sale
      purchaser.sales.create!
    end
  end
end