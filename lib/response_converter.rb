require_relative 'api_address'

class ResponseConverter
  attr_reader :address_data

  def self.bulk(addresses_data)
    addresses_data.map do |address_data|
      ApiAddress.new(address_data)
    end
  end

  def self.single(address_data)
    ApiAddress.new(address_data[0])
  end

end