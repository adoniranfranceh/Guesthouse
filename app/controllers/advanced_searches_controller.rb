class AdvancedSearchesController < ApplicationController
  def index
    @inns = Inn.active.order(:brand_name)
  end

  def search
    @inns = Inn.active.order(:brand_name)
    if params[:advanced_query]
      @inns = @inns.search_for_inns(params[:advanced_query])
    end
    if params[:accepts_pets]
      @inns = @inns.where(accepts_pets: true)
    end
    if params[:private_bathroom]
      @inns = @inns.joins(:rooms).where('rooms.private_bathroom = true')
    end
    if params[:balcony]
      @inns = @inns.joins(:rooms).where('rooms.balcony = true')
    end
    if params[:air_conditioning]
      @inns = @inns.joins(:rooms).where('rooms.air_conditioning = true')
    end
    if params[:tv]
      @inns = @inns.joins(:rooms).where('rooms.tv = true')
    end
    if params[:wardrobe]
      @inns = @inns.joins(:rooms).where('rooms.wardrobe = true')
    end
    if params[:safe_available]
      @inns = @inns.joins(:rooms).where('rooms.safe_available = true')
    end
    if params[:accessible_for_disabled]
      @inns = @inns.joins(:rooms).where('rooms.accessible_for_disabled = true')
    end
  end
end
