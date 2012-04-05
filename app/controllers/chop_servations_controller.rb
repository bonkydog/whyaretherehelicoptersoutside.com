class ChopServationsController < ApplicationController

  def create
    @chop_servation = ChopServation.new(params[:chop_servation])
    
    if @chop_servation.save
      
    else
      
    end
    render :nothing => true
  end
end
