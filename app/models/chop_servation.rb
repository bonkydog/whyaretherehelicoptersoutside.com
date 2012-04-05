class ChopServation < ActiveRecord::Base
  attr_accessor :location
  geocoded_by :location
  after_validation :geocode          # auto-fetch coordinates
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode  # auto-fetch address
end
