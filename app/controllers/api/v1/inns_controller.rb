class Api::V1::InnsController < ActionController::API
  def index
    inns = Inn.active
    render status: 200, json: inns  
  end

  def search
    result_of_search = params[:query]
    inns = Inn.active.where('brand_name LIKE ?', "%#{result_of_search}%")
    render status: 200, json: inns
  end
end
