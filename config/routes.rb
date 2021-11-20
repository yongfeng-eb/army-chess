Rails.application.routes.draw do
  root 'players#index'
  get '/players', to: 'players#index'
  post '/sign_in', to: 'players#sign_in'
  post '/home', to: 'players#home'
  post '/create', to: 'players#create'
end