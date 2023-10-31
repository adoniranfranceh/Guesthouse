class InnsController < ApplicationController
	before_action :authenticate_admin!, only: [:new, :create]
  def show
    @inn = Inn.find(params[:id])
  end

  def new
    @inn = Inn.new
  end

  def create
    @inn = Inn.new(inn_params)
    @inn.admin = current_admin
    if @inn.save
      return redirect_to @inn, notice: 'Pousada registrada com sucesso'
    end
    flash.now[:notice] = 'Pousada não foi registrada'
    render :new
  end

  private

  def inn_params
    params.require(:inn).permit(:brand_name,
                                :corporate_name,
                                :registration_number,
                                :phone,
                                :email,
                                :address,
                                :neighborhood,
                                :state,
                                :city,
                                :zip_code,
                                :description,
                                :payment_methods,
                                :accepts_pets,
                                :usage_policies,
                                :check_in,
                                :check_out)
  end
end
