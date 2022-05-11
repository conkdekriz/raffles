Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "prices#index"

  resources :prices
    get 'all', to: 'prices#all', as: 'all_prices'
  resources :raffles do
    collection do
      get :paid
      get :unpaid
      get :gracias
      get :paid
    end
    member do 
      get :response_paid
      get :response_status
    end
  end
   


end
