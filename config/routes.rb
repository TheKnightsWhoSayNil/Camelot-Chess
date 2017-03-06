Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :games do
    member do
      patch :join
    end
    resources :pieces, only: [:update, :create, :show]
  end
end
