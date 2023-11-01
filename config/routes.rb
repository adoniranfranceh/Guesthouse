Rails.application.routes.draw do
  devise_for :admins
  root "home#index"
  resources :inns, only: [:show, :new, :create, :edit, :update] do
    post :active, on: :member
    post :inactive, on: :member
    get :admin_show, on: :member
  end

  resources :rooms, only: [:index, :show]
end
