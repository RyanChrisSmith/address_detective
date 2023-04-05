# frozen_string_literal: true

require './lib/csv_reader'
require './lib/csv_address'
require './lib/response_bulk_address'
require './lib/smarty_streets_api'

class RunnerBulk  # Defines a class called RunnerBulk.
  csv_file_path = ARGV[0]  # Reads the path to the CSV file from the command line arguments.

  # Creates an instance of the CsvReader class.
  csv_reader = CsvReader.new
  # Reads the addresses from the CSV file using the CsvReader instance.
  addresses = csv_reader.read(csv_file_path)

  # Formats the addresses read from the CSV file as a list of hashes with "street", "city", and "zipcode" keys.
  formatted_addresses = addresses.collect { |add| { "street" => add.street, "city" => add.city, "zipcode" => add.zip_code } }

  # Calls the SmartyStreetsApi to validate the addresses.
  response = SmartyStreetsApi.bulk_addresses(formatted_addresses)
  # Parses the response to create a list of corrected addresses.
  corrected_addresses = ResponseBulkAddress.create_list(response)

  # Loops through the original addresses and prints out the corrected addresses (if valid) or "Invalid Address" (if invalid).
  addresses.each_with_index do |address, index|
    corrected_address = corrected_addresses.find { |c| c.index == index }

    if corrected_address
      puts "#{address.complete} -> #{corrected_address.complete}"
    else
      puts "#{address.complete} -> Invalid Address"
    end
  end
end
