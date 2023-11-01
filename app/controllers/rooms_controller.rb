class RoomsController < ApplicationController
  before_action :check_admin, only: [:edit, :update, :new, :create]
  before_action :set_room, only: [:show, :edit, :update]
  def index
  	@rooms = Room.available
  end

  def show
    @inn = Inn.find(params[:id])
  end

  def new
    @inn = Inn.find(params[:inn_id])
    @room = Room.new
  end

  def create
    @inn = Inn.find(params[:inn_id])
    @room = @inn.rooms.new(room_params)

    if @room.save
      return redirect_to @inn, notice: 'Quarto registrado com sucesso'
    end
    flash.now[:notice] = 'Quarto não foi registrado'
    render :new
  end

  def edit ;end

  def update
    if @room.update(room_params)
      return redirect_to [@inn, @room], notice: 'Quarto atualizado com sucesso'
    end
    flash.now[:notice] = 'Quarto não foi atualizado'
    render :new
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def check_admin
    @inn = Inn.find(params[:inn_id])
    if @inn.admin != current_admin
      redirect_to root_path, notice: 'Você não possui acesso'
    end
  end

  def room_params
    params.require(:room).permit(:title,
                                :description,
                                :dimension,
                                :max_occupancy,
                                :daily_rate,
                                :private_bathroom,
                                :balcony,
                                :air_conditioning,
                                :tv,
                                :wardrobe,
                                :safe_available,
                                :accessible_for_disabled)
  end
end
