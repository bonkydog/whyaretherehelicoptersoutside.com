require 'pp'

class ChopServation < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode          # auto-fetch coordinates
  before_save :reverse_geocode  # auto-fetch address
  reverse_geocoded_by :latitude, :longitude
end
