Rails.application.routes.draw do


resources :users, only: [:create, :show, :update, :destroy]
  post '/signup', to: 'users#create'
  
  post '/login', to: 'sessions#login'
  
  post '/logout', to: 'sessions#logout'
    
  
end
