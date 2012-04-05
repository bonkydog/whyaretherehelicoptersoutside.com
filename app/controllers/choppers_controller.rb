class ChoppersController < ApplicationController
  def index
    @chop_servations = ChopServation.all
    p @chop_servations
  end
end
