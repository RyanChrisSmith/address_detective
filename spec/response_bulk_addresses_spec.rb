require 'spec_helper'
require './lib/response_bulk_address'
require './lib/smarty_streets_api'

RSpec.describe ResponseBulkAddress do
  describe 'response bulk addresses from bulk API call' do
    it 'will have all correct address response objects in an array', :vcr do
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
      final_results = ResponseBulkAddress.create_list(returned_addresses)

      expect(final_results).to be_an Array
      expect(final_results.first).to be_an ResponseBulkAddress

      # The API is only returning valid addresses, so this will be missing one of the originally requested addresses
      expect(final_results.count).to eq 3
    end

    it 'each instance of ResponseBulkAddress will have attributes', :vcr do
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
      final_results = ResponseBulkAddress.create_list(returned_addresses)

      final_results.each do |result|
        expect(result.instance_variables).to eq(%i(@index @street @city @zip @plus4_code))
      end
    end

    it 'does not return any data at the index point of the original addresses if the address does not exist', :vcr do
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
      final_results = ResponseBulkAddress.create_list(returned_addresses)

      expect(addresses[2]).to eq({street: '1 Empora St', city: 'Title', zipcode: '11111'})
      expect(final_results.any? { |result| result.index == 2}).to eq false
      expect(final_results.any? { |result| result.index == 0}).to eq true
      expect(final_results.any? { |result| result.index == 1}).to eq true
      expect(final_results.any? { |result| result.index == 3}).to eq true
    end

    describe '#complete' do
      it 'will return the full address in one string' do
        address = ResponseBulkAddress.new(0, "143 e Maine St", "Columbus", "43215", "6789")

        expect(address.full_response).to eq("143 e Maine St, Columbus, 43215-6789")
      end
    end
  end
end