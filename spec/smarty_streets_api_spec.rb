# frozen_string_literal: true

require 'spec_helper'
require 'vcr'
require './lib/smarty_streets_api'

RSpec.describe SmartyStreetsApi do
  describe 'happy path' do
    it 'will successfully get a response from the Smarty Streets API', :vcr do
      returned_address = described_class.confirm_address('143 e Maine Street', 'Columbus', '43215')

      expect(returned_address).to be_an Array

      expect(returned_address[0][:delivery_line_1]).to eq('143 E Main St')
      expect(returned_address[0][:last_line]).to eq('Columbus OH 43215-5370')
    end

    describe '#conn' do
      it 'is a private method' do
        expect { described_class.conn }.to raise_error(NoMethodError)
      end

      it 'is listed in private methods' do
        expect(described_class.private_methods).to include(:conn)
      end
    end

    describe '#bulk_addresses' do
      it 'will check on up to 100 addresses or 32k in one API call', :vcr do
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
          }
        ]
        expected_response = [
          {
            "input_index": 0,
            "candidate_index": 0,
            "delivery_line_1": '1 Santa Claus Ln',
            "last_line": 'North Pole AK 99705-9901',
            "delivery_point_barcode": '997059901010',
            "components": {
              "primary_number": '1',
              "street_name": 'Santa Claus',
              "street_suffix": 'Ln',
              "city_name": 'North Pole',
              "default_city_name": 'North Pole',
              "state_abbreviation": 'AK',
              "zipcode": '99705',
              "plus4_code": '9901',
              "delivery_point": '01',
              "delivery_point_check_digit": '0'
            },
            "metadata": {
              "record_type": 'S',
              "zip_type": 'Standard',
              "county_fips": '02090',
              "county_name": 'Fairbanks North Star',
              "carrier_route": 'C004',
              "congressional_district": 'AL',
              "rdi": 'Commercial',
              "elot_sequence": '0001',
              "elot_sort": 'A',
              "latitude": 64.752140,
              "longitude": -147.353000,
              "precision": 'Zip9',
              "time_zone": 'Alaska',
              "utc_offset": -9,
              "dst": true
            },
            "analysis": {
              "dpv_match_code": 'Y',
              "dpv_footnotes": 'AABB',
              "dpv_cmra": 'N',
              "dpv_vacant": 'N',
              "dpv_no_stat": 'Y',
              "active": 'Y',
              "footnotes": 'L#'
            }
          },
          {
            "input_index": 1,
            "candidate_index": 0,
            "delivery_line_1": '1 Infinite Loop',
            "last_line": 'Cupertino CA 95014-2083',
            "delivery_point_barcode": '950142083017',
            "components": {
              "primary_number": '1',
              "street_name": 'Infinite',
              "street_suffix": 'Loop',
              "city_name": 'Cupertino',
              "default_city_name": 'Cupertino',
              "state_abbreviation": 'CA',
              "zipcode": '95014',
              "plus4_code": '2083',
              "delivery_point": '01',
              "delivery_point_check_digit": '7'
            },
            "metadata": {
              "record_type": 'S',
              "zip_type": 'Standard',
              "county_fips": '06085',
              "county_name": 'Santa Clara',
              "carrier_route": 'C067',
              "congressional_district": '17',
              "rdi": 'Commercial',
              "elot_sequence": '0037',
              "elot_sort": 'A',
              "latitude": 37.333100,
              "longitude": -122.028890,
              "precision": 'Zip9',
              "time_zone": 'Pacific',
              "utc_offset": -8,
              "dst": true
            },
            "analysis": {
              "dpv_match_code": 'Y',
              "dpv_footnotes": 'AABB',
              "dpv_cmra": 'N',
              "dpv_vacant": 'N',
              "dpv_no_stat": 'N',
              "active": 'Y'
            }
          }
        ]

        expect(SmartyStreetsApi.bulk_addresses(addresses)).to eq(expected_response)
      end
    end
  end

  describe 'sad path' do
    it 'will respond with an empty array when the address does not exist', :vcr do
      response = described_class.confirm_address('1 Empora St', 'Title', '11111')

      expect(response).to eq([])
    end

    describe 'error handling' do
      it 'handles a connection error' do
        allow(described_class).to receive(:conn).and_raise(Faraday::ConnectionFailed.new('Could not connect'))

        expect do
          described_class.confirm_address('123 Main St', 'Anytown', '12345')
        end.to raise_error(Faraday::ConnectionFailed)
      end

      it 'handles a timeout error' do
        allow(described_class).to receive(:conn).and_raise(Faraday::TimeoutError.new('Request timed out'))

        expect do
          described_class.confirm_address('123 Main St', 'Anytown', '12345')
        end.to raise_error(Faraday::TimeoutError)
      end

      it 'handles an invalid JSON response' do
        allow_any_instance_of(Faraday::Response).to receive(:body).and_return('{"foo": "bar"') # Invalid JSON response

        expect { described_class.confirm_address('123 Main St', 'Anytown', '12345') }.to raise_error(JSON::ParserError)
      end

      it 'handles 401 Unauthorized error for bad credentials correctly', :vcr do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with('SMARTY_AUTH_ID').and_return('invalid_id')
        allow(ENV).to receive(:[]).with('SMARTY_AUTH_TOKEN').and_return('invalid_token')

        expect do
          described_class.confirm_address('123 Main St', 'Anytown',
                                          '12345')
        end.to raise_error(Faraday::UnauthorizedError) do |error|
          expect(error.response[:status]).to eq(401)
        end
      end

      it 'handles 402 Payment Required error' do
        allow(described_class).to receive(:confirm_address).and_raise(Faraday::ClientError.new('Payment Required'))

        expect do
          described_class.confirm_address('123 Main St', 'Anytown',
                                          '12345')
        end.to raise_error(Faraday::ClientError, 'Payment Required')
      end

      it 'handles 413 Request Entity Too Large error' do
        allow(described_class).to receive(:confirm_address).and_raise(Faraday::ClientError.new('Request Entity Too Large'))

        expect do
          described_class.confirm_address('123 Main St', 'Anytown',
                                          '12345')
        end.to raise_error(Faraday::ClientError, 'Request Entity Too Large')
      end

      it 'handles 400 Bad Request (Malformed Payload) error' do
        allow(described_class).to receive(:confirm_address).and_raise(Faraday::BadRequestError.new('Bad Reqeust (Malformed Payload)'))

        expect do
          described_class.confirm_address('123 Main St', 'Anytown',
                                          '12345')
        end.to raise_error(Faraday::BadRequestError, 'Bad Reqeust (Malformed Payload)')
      end

      it 'handles 429 Too Many Requests error' do
        allow(described_class).to receive(:confirm_address).and_raise(Faraday::ClientError.new('Too Many Requests'))

        expect do
          described_class.confirm_address('123 Main St', 'Anytown',
                                          '12345')
        end.to raise_error(Faraday::ClientError, 'Too Many Requests')
      end

      it 'handles a 500 server error' do
        allow(described_class).to receive(:confirm_address).and_raise(Faraday::ServerError.new('Server error'))

        expect do
          described_class.confirm_address('123 Main St', 'Anytown',
                                          '12345')
        end.to raise_error(Faraday::ServerError, 'Server error')
      end
    end
  end
end
