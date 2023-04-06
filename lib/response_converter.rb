require_relative 'api_address'

class ResponseConverter

  def self.bulk(addresses_data)
    addresses_data.map do |address_data|
      index = address_data[:input_index]
      street = address_data[:delivery_line_1]
      city = address_data[:components][:city_name]
      zip = address_data[:components][:zipcode]
      plus4_code =  address_data[:components][:plus4_code]
      ApiAddress.new(street, city, zip, plus4_code, index)
    end
  end

  def self.single(address_data)
    return nil if address_data.empty?

    street = address_data[0][:delivery_line_1]
    city = address_data[0][:components][:city_name]
    zip = address_data[0][:components][:zipcode]
    plus4_code =  address_data[0][:components][:plus4_code]
    ApiAddress.new(street, city, zip, plus4_code)
  end

end