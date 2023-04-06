# frozen_string_literal: true

# ResponseAddress represents an address returned from a third-party API.
class ApiAddress
  attr_reader :street,
              :city,
              :zip,
              :plus4_code
  # Initialize with all current and potential future attributes by using a method for addition of new ones.
  def initialize(street, city, zip, plus4_code, index = nil)
    @street = street
    @city = city
    @zip = zip
    @plus4_code = plus4_code
    @index = index
  end

  # Return the full response, in the format "street, city, zip-code plus4-code".
  def validated
    "#{street}, #{city}, #{zip}-#{plus4_code}"
  end
end
