module AddressAccessor
  def street
    @address_data[0][:delivery_line_1]
  end

  def city
    @address_data[0][:components][:city_name]
  end

  def zip
    @address_data[0][:components][:zipcode]
  end

  def plus4_code
    @address_data[0][:components][:plus4_code]
  end

  def full_response
    return 'Invalid Address' if @address_data.empty?

    "#{street}, #{city}, #{zip}-#{plus4_code}"
  end
end