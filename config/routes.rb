Rails.application.routes.draw do
  devise_for :admins
  root "home#index"
  get 'city/:city' => 'inns#by_city', as: 'by_city'
  resources :inns, only: [:show, :new, :create, :edit, :update] do
    get :search, on: :collection
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
  resources :advanced_searches, only: [:index] do
    get :search, on: :collection
  end
end
