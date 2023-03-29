require 'spec_helper'
require './lib/csv_address'

RSpec.describe CsvAddress do
  describe '#initialize' do
    before :each do
      @one_address = CsvAddress.new('143 e Maine Street', 'Columbus', '43215')
    end

    it 'will make an CsvAddress object for each address from the CSV' do
      expect(@one_address).to be_a CsvAddress
    end

    it 'has attributes' do
      expect(@one_address.instance_variables).to eq(%i(@street @city @zip_code))
    end


    it 'will make an CsvAddress object with incomplete info' do
      incomplete_1 = CsvAddress.new('143 e Maine Street', 'Columbus', '43')
      incomplete_2 = CsvAddress.new('Street', 'Columbus', '43215')
      incomplete_3 = CsvAddress.new('143 e Maine Street', 'C', '43215')

      expect(incomplete_1).to be_a CsvAddress
      expect(incomplete_2).to be_a CsvAddress
      expect(incomplete_3).to be_a CsvAddress
    end
  end

  describe '#to_s' do
    it 'will return the address as one string' do
      one_address = CsvAddress.new('143 e Maine Street', 'Columbus', '43215')
      expect(one_address.to_s).to eq("143 e Maine Street, Columbus, 43215")
    end
  end

  describe 'error handling' do
    describe 'empty attributes' do
      it 'will return an argument error if any one of the attributes are empty' do
        expect { CsvAddress.new('', 'Columbus', '43215') }.to raise_error(ArgumentError, "street can't be blank")
        expect { CsvAddress.new('143 e Maine Street', '', '43215') }.to raise_error(ArgumentError, "city can't be blank")
        expect { CsvAddress.new('143 e Maine Street', 'Columbus', '') }.to raise_error(ArgumentError, "zip code can't be blank")
      end
    end
  end

end