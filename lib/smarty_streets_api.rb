# frozen_string_literal: true

require 'faraday'
require 'dotenv/load'
require 'json'

class SmartyStreetsApi
  # A public class method that makes a request to the SmartyStreets API to confirm the validity of an address.
  # Params:
  # - street: a string representing the street address.
  # - city: a string representing the city of the address.
  # - zip_code: a string representing the zip code of the address.
  # Returns:
  # - A hash containing the response from the SmartyStreets API.
  def self.confirm_address(street, city, zip_code)
    response = conn.get('/street-address?') do |req|
      req.params['street'] = street
      req.params['city'] = city
      req.params['zipcode'] = zip_code
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  # **EXTENSION**
  # A public class method that makes a request to the SmartyStreets API to confirm the validity of multiple addresses in bulk.
  # Params:
  # - addresses: an array of hashes, with each hash representing an address containing keys :street, :city, and :zip_code.
  # Returns:
  # - A hash containing the response from the SmartyStreets API.
  def self.bulk_addresses(addresses)
    response = conn.post('/street-address?') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = addresses.to_json
    end
    JSON.parse(response.body, symbolize_names: true)
  end
  # A private class method that sets up a connection to the SmartyStreets API using the Faraday gem.
  # Returns:
  # - A Faraday connection object with the base url, authentication credentials, and candidate limit set.
  private_class_method def self.conn
    Faraday.new(url: 'https://us-street.api.smartystreets.com') do |req|
      req.params['auth-id'] = ENV['SMARTY_AUTH_ID']
      req.params['auth-token'] = ENV['SMARTY_AUTH_TOKEN']
      req.params['candidates'] = '10'
      req.response :raise_error
    end
  end
end
