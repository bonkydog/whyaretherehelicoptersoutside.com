class ChoppersController < ApplicationController
  def index
    location = request.location
    @chop_servations = ChopServation.near(request.location.address, 20)
  end
end
