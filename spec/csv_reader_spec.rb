require 'spec_helper'
require './lib/csv_reader'
require './lib/address'

RSpec.describe CsvReader do
  describe 'CSV reader pulling info from the CSV file' do
    it 'will retrieve all 6 addresses from the test CSV file' do
      reader = CsvReader.new
      addresses = reader.read("./data/test_addresses.csv")

      expect(addresses.count).to eq 6
    end

    it 'will return the addresses as Address objects' do
      reader = CsvReader.new
      addresses = reader.read("./data/test_addresses.csv")

      expect(addresses.first).to be_a Address
      expect(addresses.first.to_s).to eq("143 e Maine Street, Columbus, 43215")
    end
  end
end