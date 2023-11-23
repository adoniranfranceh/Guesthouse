class Api::V1::InnsController < Api::V1::ApiController
  def index
    inns = Inn.active
    render status: 200, json: inns
  end

  def search
    result_of_search = params[:query]
    inns = Inn.active.where('brand_name LIKE ?', "%#{result_of_search}%")
    render status: 200, json: inns
  end

  def show
    inn = Inn.active.find(params[:id])
    render status: 200, json: inn.as_json(except: [:registration_number, :corporate_name])
  end
end
