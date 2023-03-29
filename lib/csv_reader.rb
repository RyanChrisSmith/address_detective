require 'csv'
class CsvReader

  def read(file_path)
    addresses = []
    CSV.foreach(file_path, headers: true) do |row|
      addresses << Address.new(street: row['Street'], city: row['City'], zip_code: row['Zip Code'])
    end
    addresses
  end
end