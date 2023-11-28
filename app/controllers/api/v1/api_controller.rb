class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :return_500
  rescue_from ActiveRecord::RecordNotFound, with: :return_404
  rescue_from Date::Error, with: :return_400_when_bad_request_at_date

  private

  def return_400_when_bad_request_at_date
    render status: 400, json: { "info": "Formato de data inválido" }
  end

  def return_500
    render status: 500, json: '{}'
  end

  def return_404
    render status: 404, json: '{}'
  end
end
