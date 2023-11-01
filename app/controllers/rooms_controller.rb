class RoomsController < ApplicationController
  def index
  	@rooms = Room.available
  end
end
