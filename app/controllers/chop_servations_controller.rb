class ChopServationsController < ApplicationController

  def create
    @chop_servation = ChopServation.new(params[:chop_servation])

    @chop_servation.save!
  end
end
