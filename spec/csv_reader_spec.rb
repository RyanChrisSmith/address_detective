require 'spec_helper'
require './lib/csv_reader'
require './lib/csv_address'

RSpec.describe CsvReader do
  describe 'CSV reader pulling info from the CSV file' do
    it 'will retrieve all addresses from the test CSV file' do
      reader = CsvReader.new
      addresses = reader.read('./data/test_addresses.csv')
      expected_count = CSV.read('./data/test_addresses.csv').count - 1

      expect(addresses.count).to eq(expected_count)
    end

    it 'will return the addresses as Address objects' do
      reader = CsvReader.new
      csv_addresses = reader.read('./data/test_addresses.csv')

      expect(csv_addresses.first).to be_a CsvAddress
      expect(csv_addresses.first.complete).to eq('143 e Maine Street, Columbus, 43215')
    end

    it 'will set the CsvAddress attributes to the correct values' do
      reader = CsvReader.new
      csv_addresses = reader.read('./data/test_addresses.csv')

      expect(csv_addresses.first.street).to eq '143 e Maine Street'
      expect(csv_addresses.first.city).to eq 'Columbus'
      expect(csv_addresses.first.zip_code).to eq '43215'
    end
  end
end
