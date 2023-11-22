class RatingsController < ApplicationController
	def create
		rating_params = params.require(:rating).permit(:grade,
                                                  :comment)
		@room_reservation = RoomReservation.find(params[:room_reservation_id])
    @rating = @room_reservation.ratings.build(rating_params)
    @rating.save
    redirect_to room_room_reservation_path(room_id: @room_reservation.room.id, id: @room_reservation.id),
                notice: 'Avaliação enviada com sucesso!'
	end
end
