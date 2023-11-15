Rails.application.routes.draw do
  devise_for :users
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
  resources :rooms, only: [:index] do
    resources :room_reservations, only: [:new, :create, :show] do
      get 'confirm', on: :collection
    end
  end
  resources :room_reservations, only: [:index] do
    get :index_admin, on: :collection
    post :cancel, on: :member
  end
  resources :advanced_searches, only: [:index] do
    get :search, on: :collection
  end
end
