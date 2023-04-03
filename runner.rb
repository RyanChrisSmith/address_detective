# frozen_string_literal: true

require './lib/csv_reader'
require './lib/csv_address'
require './lib/response_address'
require './lib/smarty_streets_api'

class Runner
  # Get the CSV file path from the command line arguments
  csv_file_path = ARGV[0]

  # Read in the CSV file
  csv_reader = CsvReader.new
  addresses = csv_reader.read(csv_file_path)

  # Validate each address using the SmartyStreets API
  addresses.each do |address|
    response = SmartyStreetsApi.confirm_address(address.street, address.city, address.zip_code)
    corrected_address = ResponseAddress.new(response)
    puts "#{address.complete} -> #{corrected_address.full_response}"
  end
end
