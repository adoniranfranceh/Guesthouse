class PriceCustomizationsController < ApplicationController
  before_action :set_inn_and_room, only: [:new, :create, :edit, :update]
  def new
  	@price_customization = PriceCustomization.new
  end

  def create
    @price_customization = @room.price_customizations.new(price_customization_params)

    if @price_customization.save
      return redirect_to [@inn, @room], notice: 'Preço customizado registrado com sucesso'
    end
    flash.now[:notice] = 'Preço customizado não foi registrado'
    render :new
  end

  def edit
    @price_customization = PriceCustomization.find(params[:id])
  end

  def update
    @price_customization = PriceCustomization.find(params[:id])
    if @price_customization.update(price_customization_params)
      return redirect_to [@inn, @room], notice: 'Preço customizado atualizado com sucesso'
    end
    flash.now[:notice] = 'Preço customizado não foi atualizado'
    render :edit
  end

  private

  def price_customization_params
    price_customization_params = params.require(:price_customization).permit(:start_date,
                                                                            :end_date,
                                                                            :daily_rate)
  end

  def set_inn_and_room
    @inn = Inn.find(params[:inn_id])
    @room = Room.find(params[:room_id])
  end
end