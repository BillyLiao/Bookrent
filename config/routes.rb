Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users
  root 'books#index'
  resources :books


  namespace :account do 
    resources :borrow
  end

  namespace :admin do
    resources :books
  end
  
  match ':controller(/:action(/:id))(.:format)', via: [:get, :post]

end
