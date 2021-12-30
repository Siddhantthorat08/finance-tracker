Rails.application.routes.draw do
  
  resources :user_stocks, only:[:create, :destroy]
  get 'stocks/search'
  devise_for :users
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'friends', to: 'users#friends'
  get 'search_stock', to: 'stocks#search'
  get 'search_friend', to: 'users#search'
  resources :friendships, only:[:create, :destroy]
end
