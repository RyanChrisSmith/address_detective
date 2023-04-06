# frozen_string_literal: true

require './lib/csv_reader'
require './lib/csv_address'
require './lib/response_converter'
require './lib/smarty_streets_api'

class RunnerBulk # Defines a class called RunnerBulk.
  begin
    csv_file_path = ARGV[0] # Reads the path to the CSV file from the command line arguments.

    # Validate CSV file path
    raise ArgumentError, 'CSV file path is required' if csv_file_path.nil? || csv_file_path.strip.empty?

    # Creates an instance of the CsvReader class.
    csv_reader = CsvReader.new
    # Reads the addresses from the CSV file using the CsvReader instance.
    addresses = csv_reader.read(csv_file_path)

    # Formats the addresses read from the CSV file as a list of hashes with "street", "city", and "zipcode" keys.
    formatted_addresses = addresses.collect do |address|
      { 'street' => address.street, 'city' => address.city, 'zipcode' => address.zip_code }
    end

    # Calls the SmartyStreetsApi to validate the addresses.
    response = SmartyStreetsApi.bulk_addresses(formatted_addresses)
    # Parses the response to create a list of corrected addresses.
    corrected_addresses = ResponseConverter.bulk(response)

    # Loops through the original addresses and prints out the corrected addresses (if valid) or "Invalid Address" (if invalid).
    addresses.each_with_index do |address, index|
      corrected_address = corrected_addresses.find { |c| c.index == index }

      if corrected_address
        puts "#{address.complete} -> #{corrected_address.validated}"
      else
        puts "#{address.complete} -> Invalid Address"
      end
    end
  # Catch ArgumentError exceptions
  rescue ArgumentError => e
    puts "Error: #{e.message}"
  # Catch all other StandardError exceptions
  rescue StandardError => e
    puts "Unexpected error: #{e.message}"
  end
end
