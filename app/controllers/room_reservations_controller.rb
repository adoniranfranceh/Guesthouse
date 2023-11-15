class RoomReservationsController < ApplicationController
  def new
    @room = Room.find(params[:room_id])
    @room_reservation = RoomReservation.new
  end

  def confirm
    @check_in = params[:check_in]
    @check_out = params[:check_out]
    @room = Room.find(params[:room_id])
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
    @room_reservation = RoomReservation.new(room_reservation_params)
    @room_reservation.room = Room.find(params[:room_id])

    @room_reservation.save!
    redirect_to root_path, notice: "Reserva confirmada para #{params[:check_in]} #{@inn.check_in}"
  end

  def room_reservation_params
    params.require(:room_reservation).permit(:check_in,
                                            :check_out,
                                            :number_of_guests)
  end
end
