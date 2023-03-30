class ResponseAddress
  # Create a reader method for the full_response attribute.
  attr_reader :full_response

  # Initialize a ResponseAddress instance with address data returned from the SmartyStreets API.
  def initialize(address_data)
    # If the address data is empty, set the full_response attribute to 'Invalid Address'.
    if !address_data.empty?
      # Extract the street, city, zip code, and plus4 code from the address data and set instance variables.
      @street = address_data[0][:delivery_line_1]
      @city = address_data[0][:components][:city_name]
      @zip = address_data[0][:components][:zipcode]
      @plus4_code = address_data[0][:components][:plus4_code]
      # Set the full_response attribute to the complete address in the format "street, city, zip-plus4".
      @full_response = "#{@street}, #{@city}, #{@zip}-#{@plus4_code}"
    else
      @full_response = 'Invalid Address'
    end
  end
end

#make full_response a method
#address_data as only attribute in initialize
#separate methods for each within address_data