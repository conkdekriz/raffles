Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "prices#index"

  resources :prices
    get 'all', to: 'prices#all', as: 'all_prices'
  resources :raffles do
    member do 
      get 'paid', to: 'raffles#paid', as: 'paid_raffles'
      get 'gracias', to: 'raffles#gracias', as: 'gracias'
      post :response_paid
    end
  end
   


end
