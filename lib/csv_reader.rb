require 'csv'

class CsvReader
  # Read the addresses from a CSV file and return an array of CsvAddress objects.
  def read(file_path)
    addresses = []
    # Read in the CSV file, downcase and strip the headers, and iterate over each row. - Allows for case and whitespace insensitivity
    CSV.foreach(file_path, headers: true, header_converters: ->(header) { header.downcase.strip }) do |row|
      # Create a new CsvAddress object from the data in each row and add it to the addresses array.
      addresses << CsvAddress.new(row['street'], row['city'], row['zip code'])
    end
    addresses
  end
end
