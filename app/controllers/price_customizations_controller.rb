class PriceCustomizationsController < ApplicationController
  before_action :set_inn_and_room, only: [:new, :create]
  def new
  	@price_customization = PriceCustomization.new
  end

  def create
    price_customization_params = params.require(:price_customization).permit(:start_date,
                                                                            :end_date,
                                                                            :daily_rate)
    @price_customization = @room.price_customizations.new(price_customization_params)

    if @price_customization.save
      return redirect_to [@inn, @room], notice: 'Preço customizado registrado com sucesso'
    end
    flash.now[:notice] = 'Preço customizado não foi registrado'
    render :new
  end

  private

  def set_inn_and_room
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
  end
end