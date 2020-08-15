require 'csv'

module SalesImporter
  class Parser
    PARSE_OPTIONS = {
      col_sep: "\t",
      headers: true,
      converters: :numeric
    }.freeze

    class << self
      def call(file_content)
        new(file_content).call
      end
    end

    def initialize(file_content)
      @file_content = file_content
    end

    def call
      CSV.
        parse(@file_content, **PARSE_OPTIONS).
        by_row!.
        map { |csv_row| Row.new(csv_row) }
    end
  end
end