# frozen_string_literal: true

require './lib/csv_reader'
require './lib/csv_address'
require './lib/response_address'
require './lib/smarty_streets_api'

class Runner
  begin
    # Get the CSV file path from the command line arguments
    csv_file_path = ARGV[0]

    # Validate CSV file path
    raise ArgumentError, "CSV file path is required" if csv_file_path.nil? || csv_file_path.strip.empty?

    # Read in the CSV file
    csv_reader = CsvReader.new
    addresses = csv_reader.read(csv_file_path)

    # Validate each address using the SmartyStreets API
    addresses.each do |address|
      response = SmartyStreetsApi.confirm_address(address.street, address.city, address.zip_code)
      corrected_address = ResponseAddress.new(response)
      puts "#{address.complete} -> #{corrected_address.full_response}"
    end
  # Catch ArgumentError exceptions
  rescue ArgumentError => e
    puts "Error: #{e.message}"
  # Catch all other StandardError exceptions
  rescue StandardError => e
    puts "Unexpected error: #{e.message}"
  end
end

