class Api::V1::RoomsController < Api::V1::ApiController
  def index
    inn = Inn.active.find(params[:inn_id])
    rooms = inn.rooms.available
    render status: 200, json: rooms
  end
end
