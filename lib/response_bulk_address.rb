require_relative 'address_accessor'
# This class represents a single address returned in the response from a bulk address API call.
class ResponseBulkAddress
  # DRY up code using a module for instance methods shared between this class and ResponseAddress class
  include AddressAccessor

  attr_reader :index,         # Index of the input address that corresponds to this response address
              :street,        # Street address line for this response address
              :city,          # City for this response address
              :zip,           # ZIP code for this response address
              :plus4_code     # Plus4 code for this response address

  # Initialize a new ResponseBulkAddress instance with the given attributes.
  def initialize(index, street, city, zip, plus4_code)
    # Index value is needed as the API does not respond with anything if the address is invalid, but skips the index instead
    @index = index
    @street = street
    @city = city
    @zip = zip
    @plus4_code = plus4_code
  end

  # Create an array of ResponseBulkAddress objects from the given array of address data returned from a bulk address API call.
  def self.create_list(addresses)
    addresses.map do |address|
      index = address[:input_index]
      street = address[:delivery_line_1]
      city = address[:components][:city_name]
      zip = address[:components][:zipcode]
      plus4_code = address[:components][:plus4_code]
      ResponseBulkAddress.new(index, street, city, zip, plus4_code)
    end
  end

  # override the #full_response method inherited from the module
  def full_response
    "#{street}, #{city}, #{zip}-#{plus4_code}"
  end
end
