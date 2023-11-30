class RoomReservationsController < ApplicationController
  before_action :set_room, only: [:show_admin, :new, :confirm, :create, :show]
  before_action :authenticate_user!, only: [:create, :index, :show]
  before_action :set_room_reservation, only: [:show, :cancel, :show_admin, :make_check_in, :cancel_admin, :make_check_out]
  before_action :authenticate_admin!, only: [:index_admin, :show_admin, :actives]
  def index_admin
    @room_reservations = current_admin.inn.room_reservations
  end

  def index
    @room_reservations = current_user.room_reservations
  end

  def actives
    @room_reservations = current_admin.inn.room_reservations.active
  end

  def show_admin; end

  def new
    @room_reservation = RoomReservation.new
  end

  def confirm
    @check_in = params[:check_in]
    @check_out = params[:check_out]
    @number_of_guests = params[:number_of_guests]
    @total_daily_rates = @room.total_price(@check_in, @check_out)
    @room_reservation = @room.room_reservations.build(check_in: @check_in, check_out: @check_out)
    return render :new if @room_reservation.unavailable_for_date?
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
    @rating = Rating.new
  end

  def cancel
    if @room_reservation.user != current_user || @room_reservation.less_than_7_days_to_check_in?
      return redirect_to root_path, notice: 'Você não tem permisão para concluir esta ação'
    end
    @room_reservation.canceled!
    redirect_to room_reservations_path, notice: 'Reserva cancelada com sucesso'
  end

  def cancel_admin
    unless @room_reservation.room.inn.admin == current_admin && @room_reservation.two_days_late_for_check_in?
      return redirect_to root_path, notice: 'Você não tem permisão para concluir esta ação'
    end
    @room_reservation.canceled!
    redirect_to index_admin_room_reservations_path, notice: 'Reserva cancelada com sucesso'
  end

  def make_check_in
    unless @room_reservation.room.inn.admin == current_admin && @room_reservation.reservation_if_check_in
      return redirect_to root_path, notice: 'Você não tem permisão para concluir esta ação'
    end
    @room_reservation.active!
    redirect_to show_admin_room_reservations_path(room_id: @room_reservation.room.id, id: @room_reservation.id),
                notice: 'Reserva ativa com sucesso'
  end

  def make_check_out
    unless @room_reservation.room.inn.admin == current_admin && @room_reservation.active?
      return redirect_to root_path, notice: 'Você não tem permisão para concluir esta ação'
    end
    @room_reservation.update(chosen_payment_method: params[:chosen_payment_method])
    @room_reservation.closed!
    redirect_to show_admin_room_reservations_path(room_id: @room_reservation.room.id, id: @room_reservation.id),
                notice: 'Reserva finalizada com sucesso'
  end

  private

  def set_room_reservation
    @room_reservation = RoomReservation.find(params[:id])
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def room_reservation_params
    params.require(:room_reservation).permit(:check_in,
                                            :check_out,
                                            :number_of_guests)
  end
end
