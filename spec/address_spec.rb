require 'spec_helper'
require './lib/address'

RSpec.describe Address do
  before :each do
    @one_address = Address.new('143 e Maine Street', 'Columbus', '43215')
  end

  it 'will make an Address object for each address from the CSV' do
    expect(@one_address).to be_a Address
  end

  it 'has attributes' do
    expect(@one_address.instance_variables).to eq(%i(@street @city @zip_code))
  end

  it 'will return the address as one string' do
    expect(@one_address.to_s).to eq("143 e Maine Street, Columbus, 43215")
  end
end