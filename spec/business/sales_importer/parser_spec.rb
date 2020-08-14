require 'rails_helper'
require 'csv'

RSpec.describe SalesImporter::Parser, type: :business do
  include_context 'Parser Context'

  describe '.call' do
    subject { described_class.call(file_content) }

    it { is_expected.to eq [importer_row] }
  end

  describe '#call' do
    subject { described_class.new(file_content).call }

    it { is_expected.to eq [importer_row] }
  end
end