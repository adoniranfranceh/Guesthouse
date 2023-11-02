Rails.application.routes.draw do
  devise_for :admins
  root "home#index"
  resources :inns, only: [:show, :new, :create, :edit, :update] do
    resources :rooms, only: [:show, :new, :create, :edit, :update] do
      resources :price_customizations, only: [:new, :create, :edit, :update]
      post :available, on: :member
      post :unavailable, on: :member
    end
    post :active, on: :member
    post :inactive, on: :member
    get :admin_show, on: :member
  end
  resources :rooms, only: [:index]
end
