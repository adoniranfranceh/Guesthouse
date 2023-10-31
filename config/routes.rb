Rails.application.routes.draw do
  devise_for :admins
  root "home#index"
  resources :inns, only: [:show, :new, :create]
end
