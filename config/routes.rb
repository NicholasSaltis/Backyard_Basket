Rails.application.routes.draw do
  resources :products
  resources :profiles
  get 'home/index'
  get 'home/browse', to: 'home#browse', as: 'browse'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"home#index"
end
