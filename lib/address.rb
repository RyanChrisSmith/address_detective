class Address
  attr_reader :street,
              :city,
              :zip_code

  def initialize(street, city, zip_code)
    @street = street.strip
    @city = city.strip
    @zip_code = zip_code.strip
  end

  def to_s
    "#{street}, #{city}, #{zip_code}"
  end
end