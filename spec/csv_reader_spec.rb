require 'spec_helper'
require './lib/csv_reader'

RSpec.describe CsvReader do
  describe 'CSV reader pulling info from the CSV file' do
    it 'will retrieve the addresses from the CSV file' do
      reader = CsvReader.new

      expect(reader.read("./data/addresses.csv")).to eq([])
    end
  end
end