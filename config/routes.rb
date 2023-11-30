Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root "home#index"
  get 'city/:city' => 'inns#by_city', as: 'by_city'
  resources :inns, only: [:show, :new, :create, :edit, :update] do
    delete 'delete_photo/:photo_id', to: 'inns#delete_photo', as: 'delete_photo', on: :member
    resources :ratings, only: [:index]
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
    delete 'delete_photo/:photo_id', to: 'rooms#delete_photo', as: 'delete_photo', on: :member
    resources :room_reservations, only: [:new, :create, :show] do
      get 'confirm', on: :collection
    end
  end
  resources :room_reservations, only: [:index] do
    resources :ratings, only: [:create, :index]
    collection do
      get :index_admin
      get :show_admin
      get :actives
    end
    member do
      post :cancel_admin
      post :cancel
      post :make_check_in
      post :make_check_out
    end
  end
  resources :ratings, only: [:show] do
    get :index_admin, on: :collection
    get :show_admin, on: :member
    resources :review_responses, only: [:create]
  end
  resources :advanced_searches, only: [:index] do
    get :search, on: :collection
  end

  namespace :api do
    namespace :v1 do
      resources :inns, only: [:index, :show] do
        resources :rooms, only: [:index]
        get :search, on: :collection
      end
      resources :rooms, only: [] do
        resources :room_reservations, only: [] do
          get :available, on: :collection
        end
      end
    end
  end
end
