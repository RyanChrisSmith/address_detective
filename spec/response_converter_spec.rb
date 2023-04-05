require 'spec_helper'
require './lib/response_converter'
require './lib/smarty_streets_api'

RSpec.describe ResponseConverter do
  it 'will return a single ApiAddress object', :vcr do
    returned_address = SmartyStreetsApi.confirm_address('143 e Maine Street', 'Columbus', '43215')

    converted = ResponseConverter.single(returned_address)

    expect(converted).to be_a ApiAddress
  end

  it 'will return multiple ApiAddress objects', :vcr do
    addresses = [
      {
        "street": '1 Santa Claus',
        "city": 'North Pole',
        "zipcode": '99705'
      },
      {
        "street": '1 infinite loop',
        "city": 'cupertino',
        "zipcode": '95014'
      },
      {
        "street": '1 Empora St',
        "city": 'Title',
        "zipcode": '11111'
      },
      {
        "street": '143 e Maine Street',
        "city": 'Columbus',
        "zipcode": '43215'
      }
    ]
    returned_addresses = SmartyStreetsApi.bulk_addresses(addresses)
    converted_addresses = ResponseConverter.bulk(returned_addresses)

    converted_addresses.each do |address|
      expect(address).to be_an ApiAddress
    end
  end
end
