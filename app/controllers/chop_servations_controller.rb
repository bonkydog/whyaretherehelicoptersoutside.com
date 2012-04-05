class ChopServationsController < ApplicationController

  def create
    @chop_servation = ChopServation.new(params[:chop_servation])

    @chop_servation.save!

    @sighted = @chop_servation.sighted?
    @message = if @sighted
      "That's really annoying! Maybe this will help?"
    else
      "Good to know!"
    end
  end
end
