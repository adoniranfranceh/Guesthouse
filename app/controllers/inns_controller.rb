class InnsController < ApplicationController
	before_action :authenticate_admin!, only: [:new, :create]
  before_action :set_inn_and_check_admin, only: [:edit, :update, :active, :inactive]
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

  def edit; end

  def update
    if @inn.update(inn_params)
      return redirect_to @inn, notice: 'Pousada atualizada com sucesso'
    end
    flash.now[:notice] = 'Pousada não atualizada'
    render :edit
  end

  def active
    @inn.active!
    redirect_to @inn, notice: 'Sua pousada está ativa'
  end

  def inactive
    @inn.inactive!
    redirect_to @inn, notice: 'Sua pousada está inativa'
  end

  private

  def set_inn_and_check_admin
    @inn = Inn.find(params[:id])
    if @inn.admin != current_admin
      redirect_to root_path, notice: 'Você não é dono dessa pousada'
    end
  end

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
