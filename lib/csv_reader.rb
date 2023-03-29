require 'csv'
class CsvReader

  def read(file_path)
    addresses = []
    CSV.foreach(file_path, headers: true) do |row|
      addresses << Address.new(row['Street'], row['City'], row['Zip Code'])
    end
    addresses
  end
end