Rails.application.routes.draw do

  resource :dahsboard, only: [:index]
  root "dashboard#index"

end
