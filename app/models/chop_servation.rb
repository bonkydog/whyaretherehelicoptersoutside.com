require 'pp'

class ChopServation < ActiveRecord::Base
  attr_accessor :location
  geocoded_by :location
  after_validation :geocode          # auto-fetch coordinates
  after_validation :reverse_geocode  # auto-fetch address
  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      pp geo.data["address_components"][4]["short_name"]
      obj.location = geo.data["address_components"][4]["short_name"]
    end
  end
end
