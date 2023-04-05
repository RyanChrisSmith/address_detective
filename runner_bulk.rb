# frozen_string_literal: true

require './lib/csv_reader'
require './lib/csv_address'
require './lib/response_bulk_address'
require './lib/smarty_streets_api'

class RunnerBulk
  csv_file_path = ARGV[0]

  csv_reader = CsvReader.new
  addresses = csv_reader.read(csv_file_path)

  formatted_addresses = addresses.collect { |add| { "street" => add.street, "city" => add.city, "zipcode" => add.zip_code } }

  response = SmartyStreetsApi.bulk_addresses(formatted_addresses)
  corrected_addresses = ResponseBulkAddress.create_list(response)

  addresses.each_with_index do |address, index|
    corrected_address = corrected_addresses.find { |c| c.index == index }

    if corrected_address
      puts "#{address.complete} -> #{corrected_address.complete}"
    else
      puts "#{address.complete} -> Invalid Address"
    end
  end
end