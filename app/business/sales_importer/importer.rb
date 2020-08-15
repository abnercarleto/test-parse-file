module SalesImporter
  class Importer
    class << self
      def call(*args, **kwargs)
        new(*args, **kwargs).call
      end
    end

    def initialize(file_content, parser: Parser,
                                 group_importer: PurchaserImporter)
      @file_content = file_content
      @parser = parser
      @group_importer = group_importer
    end

    def call
      ActiveRecord::Base.transaction do
        parser.
          call(file_content).
          then { |rows| rows.group_by { |row| row.purchaser_name } }.
          map { |key, group| group_importer.call(sale_import, key, group) }
      end

      sale_import
    end

    private

    attr_reader :file_content, :parser, :group_importer

    def sale_import
      @sale_import ||= SaleImport.create!
    end
  end
end