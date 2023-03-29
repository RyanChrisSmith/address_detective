require 'faraday'
require 'dotenv/load'
require 'json'

class SmartyStreetsApi

  def self.confirm_address(street, city, zip_code)
    response = conn.get('/street-address?') do |req|
      req.params['street'] = "#{street}"
      req.params['city'] = "#{city}"
      req.params['zipcode'] = "#{zip_code}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def self.conn
    Faraday.new(url: "https://us-street.api.smartystreets.com") do |req|
      req.params['auth-id'] = ENV['SMARTY_AUTH_ID']
      req.params['auth-token'] = ENV['SMARTY_AUTH_TOKEN']
      req.params['candidates'] = '10'
    end
  end
end