class RoomReservationsController < ApplicationController
  before_action :set_room, except: [:index]
  before_action :authenticate_user!, only: [:create, :index, :show]
  def index
    @room_reservations = current_user.room_reservations
  end
  def new
    @room_reservation = RoomReservation.new
  end

  def confirm
    @check_in = params[:check_in]
    @check_out = params[:check_out]
    @number_of_guests = params[:number_of_guests]
    @total_daily_rates = @room.total_price(@check_in, @check_out)
    @room_reservation = @room.room_reservations.build(check_in: @check_in, check_out: @check_out)
    return render :new if @room_reservation.there_is_a_reservation_for_that_date
    unless @check_in.present? || @check_out.present? || @number_of_guests.present?
      flash.now[:alert] = 'Preencha todos os campos corretamente'
      return render :new
    end
  end

  def create
    @room_reservation = @room.room_reservations.build(room_reservation_params)
    @room_reservation.user = current_user
    @room_reservation.save!
    redirect_to room_reservations_path, notice: "Nova reserva registrada"
  end

  def show
    @room_reservation = RoomReservation.find(params[:id])
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def room_reservation_params
    params.require(:room_reservation).permit(:check_in,
                                            :check_out,
                                            :number_of_guests)
  end
end
