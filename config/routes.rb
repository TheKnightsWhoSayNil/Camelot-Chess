Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks"}
  root 'static_pages#index'
  resources :games do
    member do
      patch :join
    end
    resources :pieces, only: [:update, :create, :show]
  end
end
