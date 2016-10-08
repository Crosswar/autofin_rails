Rails.application.routes.draw do

  resource :dashboard, only: [:index]

  resources :clients do
    collection { post :import }
  end

  root "dashboard#index"

end
