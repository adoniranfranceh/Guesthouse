class ReviewResponsesController < ApplicationController
  before_action :authenticate_admin!
  def create
    review_response_params = params.require(:review_response).permit(:comment)
    @rating = Rating.find(params[:rating_id])
    @review_response = @rating.review_responses.build(review_response_params)

    @review_response.save
    redirect_to show_admin_rating_path(@rating.id), notice: 'Resposta enviada com sucesso'
  end
end
