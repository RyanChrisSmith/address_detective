require 'spec_helper'
require 'vcr'
require './lib/smarty_streets_api'

RSpec.describe SmartyStreetsApi do
  it 'will successfully get a response from the Smarty Streets API', :vcr do
    returned_address = SmartyStreetsApi.confirm_address('143 e Maine Street', 'Columbus', '43215')

    expect(returned_address).to be_an Array

    expect(returned_address[0][:delivery_line_1]).to eq('143 E Main St')
    expect(returned_address[0][:last_line]).to eq('Columbus OH 43215-5370')
  end

  it "will respond with an empty array when the address does not exist", :vcr do
    response = SmartyStreetsApi.confirm_address('1 Empora St', 'Title', '11111')

    expect(response).to eq([])
  end
end