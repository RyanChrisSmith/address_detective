class ResponseAddress
  attr_reader :full_response

  def initialize(address_data)
    if !address_data.empty?
      @street = address_data[0][:delivery_line_1]
      @city = address_data[0][:components][:city_name]
      @zip = address_data[0][:components][:zipcode]
      @plus4_code = address_data[0][:components][:plus4_code]
      @full_response = "#{@street}, #{@city}, #{@zip}-#{@plus4_code}"
    else
      @full_response = 'Invalid Address'
    end
  end
end