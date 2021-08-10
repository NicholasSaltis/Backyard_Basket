Rails.application.routes.draw do
  resources :products
  resources :profiles
  get 'home/index'
  get 'home/browse', to: 'home#browse', as: 'browse'
  get 'messages/index', to: 'messages#index', as: 'messages'
  get 'messages/show/:id', to: 'messages#show', as: 'message'
  post 'messages/new_message', to: 'messages#new_message', as: 'new_message'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"home#index"
end
