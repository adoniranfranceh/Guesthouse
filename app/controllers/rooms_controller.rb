class RoomsController < ApplicationController
  def index
  	@rooms = Room.available
  end

  def show
    @room = Room.find(params[:id])
  end
end
