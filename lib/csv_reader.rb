# frozen_string_literal: true

require 'csv'

class CsvReader
  # Read the addresses from a CSV file and return an array of CsvAddress objects.
  def read(file_path)
    # Use the CSV library to read in the CSV file.
    # The headers option tells CSV to treat the first row as column headers.
    # The header_converters option uses a lambda to downcase and strip each header allowing for case and whitespace insensitivity.
    # The resulting CSV::Table object is returned by CSV.foreach method.
    # We call the map method on this table object to transform each row into a CsvAddress object
    # The resulting array of CsvAddress objects is returned by the map method.
    CSV.foreach(file_path, headers: true, header_converters: ->(header) { header.downcase.strip })
       .map { |row| CsvAddress.new(row['street'], row['city'], row['zip code']) }
  end
end
