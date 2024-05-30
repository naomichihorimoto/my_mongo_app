Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create] do
    collection { post :import }
  end
  root "users#index"
end
