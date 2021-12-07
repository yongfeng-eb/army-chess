Rails.application.routes.draw do
  root 'players#index'

  get '/realtime_info', to: 'players#realtime'
  post '/prepared', to: 'preset_chess_layouts#prepared'
  get '/prepared', to: 'preset_chess_layouts#prepared'
  post '/choose_preset', to: 'preset_chess_layouts#choose'
  get '/choose_preset', to: 'preset_chess_layouts#choose'
  get '/place_chess', to: 'preset_positions#create'
  post '/place_chess', to: 'preset_positions#create'
  post '/create_room', to: 'rooms#create'
  get '/rooms', to: 'rooms#index'
  get '/playing', to: 'real_time#playing'
  post '/playing', to: 'real_time#playing'
  get '/players', to: 'players#index'
  post '/sign_up', to: 'players#sign_up'
  get '/sign_up', to: 'players#sign_up'
  post '/home', to: 'players#home'
  get '/home', to: 'players#access_home'
  post '/create', to: 'players#create'
end
