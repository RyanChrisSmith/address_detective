require_relative 'api_address'
# This class converts response data from SmartyStreets API into ApiAddress objects.
class ResponseConverter
  # This method converts a single address from SmartyStreets API response into an ApiAddress object.
  def self.single(address_data)
    # If the address_data is empty, return nil.
    return nil if address_data.empty?

    # Extract the street, city, zip, and plus4 code from the response data.
    street = address_data[0][:delivery_line_1]
    city = address_data[0][:components][:city_name]
    zip = address_data[0][:components][:zipcode]
    plus4_code = address_data[0][:components][:plus4_code]

    # Create and return a new ApiAddress object with the extracted data.
    ApiAddress.new(street, city, zip, plus4_code)
  end

  # This method converts a list of addresses from SmartyStreets API response into a list of ApiAddress objects.
  def self.bulk(addresses_data)
    # Map over each address data in the list and create an ApiAddress object for each one.
    addresses_data.map do |address_data|
      # Extract the index, street, city, zip, and plus4 code from the response data.
      index = address_data[:input_index]
      street = address_data[:delivery_line_1]
      city = address_data[:components][:city_name]
      zip = address_data[:components][:zipcode]
      plus4_code = address_data[:components][:plus4_code]

      # Create and return a new ApiAddress object with the extracted data and the input index.
      ApiAddress.new(street, city, zip, plus4_code, index)
    end
  end
end
