require 'spec_helper'
require './lib/response_address'
require './lib/smarty_streets_api'

RSpec.describe ResponseAddress do
  describe 'response of good and bad addresses from API', :vcr do
    it 'will return a proper address when a good csv address is sent out' do
      returned_address = SmartyStreetsApi.confirm_address('143 e Maine Street', 'Columbus', '43215')
      verified = ResponseAddress.new(returned_address)

      expect(verified).to be_a ResponseAddress
      expect(verified.full_response).to eq('143 E Main St, Columbus, 43215-5370')
    end

    it "will return 'Invalid Address' if the csv address doesnt exist", :vcr do
      returned_address = SmartyStreetsApi.confirm_address('1 Empora St', 'Title', '11111')
      unverified = ResponseAddress.new(returned_address)

      expect(unverified.full_response).to eq('Invalid Address')
    end
  end
end