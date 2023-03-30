# CsvAddress represents an address in a CSV file.
class CsvAddress
  # Create reader methods for the street, city, and zip_code attributes.
  attr_reader :street,
              :city,
              :zip_code

  # Initialize a CsvAddress instance with a street, city, and zip code.
  def initialize(street, city, zip_code)
    # Raise an ArgumentError if any of the arguments are empty.
    raise ArgumentError, "street can't be blank" if street.strip.empty?
    raise ArgumentError, "city can't be blank" if city.strip.empty?
    raise ArgumentError, "zip code can't be blank" if zip_code.strip.empty?

    # Set instance variables for street, city, and zip code (stripped of whitespace).
    @street = street.strip
    @city = city.strip
    @zip_code = zip_code.strip
  end

  # Return a string representation of the CsvAddress in the format "street, city, zip_code".
  def to_s
    "#{street}, #{city}, #{zip_code}"
  end
end