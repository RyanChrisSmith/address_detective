# frozen_string_literal: true

# CsvAddress represents an address in a CSV file.
class CsvAddress
  # Create reader methods for the street, city, and zip_code attributes.
  attr_reader :street,
              :city,
              :zip_code

  # Initialize a CsvAddress instance with a street, city, and zip code.
  # This method validates that the provided arguments are not empty or nil, and sets
  # instance variables for street, city, and zip code (stripped of whitespace).
  def initialize(street, city, zip_code)
    validate_presence_of_arg(street, 'street')
    validate_presence_of_arg(city, 'city')
    validate_presence_of_arg(zip_code, 'zip code')

    @street = street.strip
    @city = city.strip
    @zip_code = zip_code.strip
  end

  # Returns a string representation of the CsvAddress in the format "street, city, zip_code".
  def complete
    "#{street}, #{city}, #{zip_code}"
  end

  # Raises an ArgumentError if arg is empty or nil.
  # Helper method to DRY up code
  def validate_presence_of_arg(arg, name)
    raise ArgumentError, "#{name} can't be blank" if arg.nil? || arg.strip.empty?
  end
end
