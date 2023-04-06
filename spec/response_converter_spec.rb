require 'spec_helper'
require './lib/response_converter'
require './lib/smarty_streets_api'

RSpec.describe ResponseConverter do
  describe '.bulk' do
    let(:addresses_data) do
      [
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
        },
        {
          "input_index": 3,
          "candidate_index": 0,
          "delivery_line_1": '143 E Main St',
          "last_line": 'Columbus OH 43215-5370',
          "delivery_point_barcode": '432155370992',
          "components": {
            "primary_number": '143',
            "street_predirection": 'E',
            "street_name": 'Main',
            "street_suffix": 'St',
            "city_name": 'Columbus',
            "default_city_name": 'Columbus',
            "state_abbreviation": 'OH',
            "zipcode": '43215',
            "plus4_code": '5370',
            "delivery_point": '99',
            "delivery_point_check_digit": '2'
          },
          "metadata": {
            "record_type": 'H',
            "zip_type": 'Standard',
            "county_fips": '39049',
            "county_name": 'Franklin',
            "carrier_route": 'C023',
            "congressional_district": '03',
            "building_default_indicator": 'Y',
            "rdi": 'Commercial',
            "elot_sequence": '0232',
            "elot_sort": 'A',
            "latitude": 39.956700,
            "longitude": -82.993840,
            "precision": 'Zip9',
            "time_zone": 'Eastern',
            "utc_offset": -5,
            "dst": true
          },
          "analysis": {
            "dpv_match_code": 'D',
            "dpv_footnotes": 'AAN1',
            "dpv_cmra": 'N',
            "dpv_vacant": 'N',
            "dpv_no_stat": 'Y',
            "active": 'Y',
            "footnotes": 'H#M#'
          }
        }
      ]
    end

    it 'converts bulk addresses into an array of ApiAddress objects' do
      api_addresses = ResponseConverter.bulk(addresses_data)

      expect(api_addresses.length).to eq(3)

      expect(api_addresses[0]).to be_a(ApiAddress)
      expect(api_addresses[0].street).to eq('1 Santa Claus Ln')
      expect(api_addresses[0].city).to eq('North Pole')
      expect(api_addresses[0].zip).to eq('99705')
      expect(api_addresses[0].plus4_code).to eq('9901')
      expect(api_addresses[0].index).to eq(0)

      expect(api_addresses[1]).to be_a(ApiAddress)
      expect(api_addresses[1].street).to eq('1 Infinite Loop')
      expect(api_addresses[1].city).to eq('Cupertino')
      expect(api_addresses[1].zip).to eq('95014')
      expect(api_addresses[1].plus4_code).to eq('2083')
      expect(api_addresses[1].index).to eq(1)

      expect(api_addresses[2]).to be_a(ApiAddress)
      expect(api_addresses[2].street).to eq('143 E Main St')
      expect(api_addresses[2].city).to eq('Columbus')
      expect(api_addresses[2].zip).to eq('43215')
      expect(api_addresses[2].plus4_code).to eq('5370')
      expect(api_addresses[2].index).to eq(3)
    end
  end

  describe '.single' do
    let(:address_data) do
      [
        {
          "input_index": 0,
          "candidate_index": 0,
          "delivery_line_1": '143 E Main St',
          "last_line": 'Columbus OH 43215-5370',
          "components": {
            "primary_number": '143',
            "street_predirection": 'E',
            "street_name": 'Main',
            "street_suffix": 'St',
            "city_name": 'Columbus',
            "default_city_name": 'Columbus',
            "state_abbreviation": 'OH',
            "zipcode": '43215',
            "plus4_code": '5370',
            "delivery_point": '99',
            "delivery_point_check_digit": '2'
          },
          "metadata": {
            "record_type": 'H',
            "zip_type": 'Standard',
            "county_fips": '39049',
            "county_name": 'Franklin',
            "building_default_indicator": 'Y',
            "latitude": 39.956700,
            "longitude": -82.993840,
            "precision": 'Zip9',
            "time_zone": 'Eastern',
            "utc_offset": -5,
            "dst": true
          },
          "analysis": {
            "dpv_match_code": 'D',
            "dpv_footnotes": 'AAN1',
            "dpv_cmra": 'N',
            "dpv_vacant": 'N',
            "dpv_no_stat": 'Y',
            "active": 'Y',
            "footnotes": 'H#M#'
          }
        }
      ]
    end

    it 'converts a single address data into an ApiAddress object' do
      api_address = ResponseConverter.single(address_data)

      expect(api_address).to be_a(ApiAddress)
      expect(api_address.street).to eq('143 E Main St')
      expect(api_address.city).to eq('Columbus')
      expect(api_address.zip).to eq('43215')
      expect(api_address.plus4_code).to eq('5370')
    end

    it 'returns nil if address data is empty' do
      api_address = ResponseConverter.single([])

      expect(api_address).to be_nil
    end
  end
end
