require 'spec_helper'
require './lib/csv_reader'
require './lib/csv_address'

RSpec.describe CsvReader do
  describe 'CSV reader pulling info from the CSV file' do
    it 'will retrieve all 6 addresses from the test CSV file' do
      reader = CsvReader.new
      addresses = reader.read("./data/test_addresses.csv")

      expect(addresses.count).to eq 6
    end

    it 'will return the addresses as Address objects' do
      reader = CsvReader.new
      csv_addresses = reader.read("./data/test_addresses.csv")

      expect(csv_addresses.first).to be_a CsvAddress
      expect(csv_addresses.first.complete).to eq("143 e Maine Street, Columbus, 43215")
    end
  end
end