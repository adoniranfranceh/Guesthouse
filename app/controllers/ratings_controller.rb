class RatingsController < ApplicationController
  before_action :authenticate_admin!, only: [:index_admin, :show_admin]
  before_action :authenticate_user!, only: [:create]
  before_action :set_rating, only: [:show_admin, :show]
  def create
    rating_params = params.require(:rating).permit(:grade,
                                                  :comment)
    @room_reservation = RoomReservation.find(params[:room_reservation_id])
    @rating = @room_reservation.build_rating(rating_params)
    @rating.save
    redirect_to room_room_reservation_path(room_id: @room_reservation.room.id, id: @room_reservation.id),
                notice: 'Avaliação enviada com sucesso!'
  end

  def index_admin
    @ratings = current_admin.inn.ratings if current_admin.inn.present?
  end

  def show_admin
    @review_response = ReviewResponse.new
  end

  def show; end

  def index
    @inn = Inn.find(params[:inn_id])
    @ratings = @inn.ratings
  end

  private

  def set_rating
    @rating = Rating.find(params[:id])
  end
end
