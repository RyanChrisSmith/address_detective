require 'csv'

class CsvReader
  # Read the addresses from a CSV file and return an array of CsvAddress objects.
  def read(file_path)
    addresses = []
    CSV.foreach(file_path, headers: true) do |row|
      # Create a new CsvAddress object from the data in each row and add it to the addresses array.
      addresses << CsvAddress.new(row['Street'], row[' City'], row[' Zip Code'])
    end
    addresses
  end
end


#fix row reading as it comes in, eliminate spaces and capitalization concerns - no parsing errors