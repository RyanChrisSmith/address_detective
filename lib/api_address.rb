# frozen_string_literal: true

# ResponseAddress represents an address returned from a third-party API.
class ApiAddress
  # Initialize with all current and potential future attributes by using a method for addition of new ones.
  def initialize(address_data)
    @address_data = address_data
  end

  def index
    @address_data[:input_index]
  end

  # Return the street address.
  def street
    @address_data[:delivery_line_1]
  end

  # Return the city.
  def city
    @address_data[:components][:city_name]
  end

  # Return the zip code.
  def zip
    @address_data[:components][:zipcode]
  end

  # Return the plus4 code (if any).
  def plus4_code
    @address_data[:components][:plus4_code]
  end

  # Return the full response, in the format "street, city, zip-code plus4-code".
  def validated
    return 'Invalid Address' if @address_data.nil? || @address_data.empty?

    "#{street}, #{city}, #{zip}-#{plus4_code}"
  end
end
