Rails.application.routes.draw do
  get 'home/index'
  resources :my_deals , only: [:index] do
    member do 
      get 'borrower_info' ,to: 'my_deals#contact_borrower'
      get 'bid_request_info'
      post 'create_bid'
    end  
  end 
  resources :borrower_requests do 
    member do 
      get 'contact_broker'
      post 'publish_request'
      post 'cancel_request'
      post 'accept_broker'
    end 
  end 
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations' }
  resources :profiles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
