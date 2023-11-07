class HomeController < ApplicationController
  def index
    @inns = Inn.active
    @recent_inns = Inn.active.order(created_at: :desc).limit(3)
    @rest_of_the_inns = Inn.active.where.not(id: @recent_inns.pluck(:id))
    @cities = @inns.pluck(:city).uniq!
  end
end
