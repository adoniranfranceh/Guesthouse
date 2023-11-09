class AdvancedSearchesController < ApplicationController
  def index
    @inns = Inn.active.order(:brand_name)
  end

  def search
    inns = Inn.active.includes(:rooms).order(:brand_name)
    filter_params = {
      accepts_pets: "accepts_pets",
      private_bathroom: "rooms.private_bathroom",
      balcony: "rooms.balcony",
      air_conditioning: "rooms.air_conditioning",
      tv: "rooms.tv",
      wardrobe: "rooms.wardrobe",
      safe_available: "rooms.safe_available",
      accessible_for_disabled: "rooms.accessible_for_disabled"
    }

    filter_params.each do |attribute, param_name|
      @inns = inns.where(param_name => true) if params[attribute] == "true"
    end
  end
end
