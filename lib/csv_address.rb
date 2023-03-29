class CsvAddress
  attr_reader :street,
              :city,
              :zip_code

  def initialize(street, city, zip_code)
    raise ArgumentError, "street can't be blank" if street.strip.empty?
    raise ArgumentError, "city can't be blank" if city.strip.empty?
    raise ArgumentError, "zip code can't be blank" if zip_code.strip.empty?

    @street = street.strip
    @city = city.strip
    @zip_code = zip_code.strip
  end

  def to_s
    "#{street}, #{city}, #{zip_code}"
  end
end