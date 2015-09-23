Rails.application.routes.draw do
  
  root 'welcome#index'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users, only: [:new, :create]
  resources :links, only: [:index, :create, :update]
end
