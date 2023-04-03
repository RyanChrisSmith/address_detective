# frozen_string_literal: true

require 'spec_helper'
require './lib/response_address'
require './lib/smarty_streets_api'

RSpec.describe ResponseAddress do
  describe 'response of good and bad addresses from API' do
    it 'will return a proper address when a good csv address is sent out', :vcr do
      returned_address = SmartyStreetsApi.confirm_address('143 e Maine Street', 'Columbus', '43215')
      verified = described_class.new(returned_address)

      expect(verified).to be_a described_class
      expect(verified.full_response).to eq('143 E Main St, Columbus, 43215-5370')
    end

    it "will return 'Invalid Address' if the csv address doesnt exist", :vcr do
      returned_address = SmartyStreetsApi.confirm_address('1 Empora St', 'Title', '11111')
      unverified = described_class.new(returned_address)

      expect(unverified.full_response).to eq('Invalid Address')
    end

    it "will return the street address when the 'street' method is called", :vcr do
      returned_address = SmartyStreetsApi.confirm_address('123 Main St', 'Columbus', '43215')
      response = described_class.new(returned_address)

      expect(response.street).to eq('123 E Main St')
    end

    it "will return the city when the 'city' method is called", :vcr do
      returned_address = SmartyStreetsApi.confirm_address('123 Main St', 'Columbus', '43215')
      response = described_class.new(returned_address)

      expect(response.city).to eq('Columbus')
    end

    it "will return the zip code when the 'zip' method is called", :vcr do
      returned_address = SmartyStreetsApi.confirm_address('123 Main St', 'Columbus', '43215')
      response = described_class.new(returned_address)

      expect(response.zip).to eq('43215')
    end

    it "will return the plus4 code when the 'plus4_code' method is called", :vcr do
      returned_address = SmartyStreetsApi.confirm_address('143 e Maine Street', 'Columbus', '43215')
      response = described_class.new(returned_address)

      expect(response.plus4_code).to eq('5370')
    end
  end
end
