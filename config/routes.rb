Rails.application.routes.draw do
  root 'players#index'
  get '/players', to: 'players#index'
  post '/sign_up', to: 'players#sign_up'
  post '/home', to: 'players#home'
  post '/create', to: 'players#create'
end