require 'spec_helper'
require './lib/api_address'

RSpec.describe ApiAddress do
  let(:street) { '123 Main St' }
  let(:city) { 'Anytown' }
  let(:zip) { '12345' }
  let(:plus4_code) { '6789' }
  let(:index) { 1 }
  subject { described_class.new(street, city, zip, plus4_code, index) }

  describe '#initialize' do
    it 'sets the street attribute' do
      expect(subject.street).to eq(street)
    end

    it 'sets the city attribute' do
      expect(subject.city).to eq(city)
    end

    it 'sets the zip attribute' do
      expect(subject.zip).to eq(zip)
    end

    it 'sets the plus4_code attribute' do
      expect(subject.plus4_code).to eq(plus4_code)
    end

    it 'sets the index attribute' do
      expect(subject.index).to eq(index)
    end

    context 'when index is not provided' do
      subject { described_class.new(street, city, zip, plus4_code) }

      it 'sets the index attribute to nil' do
        expect(subject.index).to be_nil
      end
    end
  end

  describe '#validated' do
    it 'returns the full validated address' do
      expect(subject.validated).to eq("#{street}, #{city}, #{zip}-#{plus4_code}")
    end
  end
end
