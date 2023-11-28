class Api::V1::RoomReservationsController < Api::V1::ApiController
  def available
    room = Room.find(params[:room_id])

    check_in = Date.parse(params[:check_in]) if params[:check_in].present?
    check_out = Date.parse(params[:check_out]) if params[:check_out].present?

    number_of_guests = params[:number_of_guests]

    if check_in.blank? || check_out.blank? || number_of_guests.blank?
      return render status: 400, json: { "info": "Preencha todos os campos corretamente" }
    end

    total_daily_rates = room.total_price(check_in, check_out)
    room_reservation = room.room_reservations.build(check_in: check_in, check_out: check_out)
    render status: 200, json: reservation_available(room_reservation, total_daily_rates)
  end

  def reservation_available(room_reservation, total_daily_rates)
    if room_reservation.unavailable_for_date?
      return { "status": "não disponível", "info": "O quarto não está disponível para as datas solicitadas." }
    end

    {
      "status": "disponível",
      "total": total_daily_rates
    }
  end
end

