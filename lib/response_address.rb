# frozen_string_literal: true

require_relative 'address_accessor'
# ResponseAddress represents an address returned from a third-party API.
class ResponseAddress
  # DRY up code using a module for instance methods shared between this class and ResponseAddress class
  include AddressAccessor
  # Initialize with all current and potential future attributes by using a method for addition of new ones.
  def initialize(address_data)
    @address_data = address_data
  end

end
