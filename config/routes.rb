Rails.application.routes.draw do

  resource :dashboard, only: [:index]
  resources :clients

  resources :settings

  root "dashboard#index"

end
