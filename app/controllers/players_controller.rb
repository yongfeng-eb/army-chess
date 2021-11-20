class PlayersController < ApplicationController
  def index
  end

  def home
    @current_player_id = params[:user_id]
    @player = Player.find_by(user_id: @current_player_id)

    if @player.password != params[:password]
      render 'index'
    end

    @leader_board_lines = LeaderBoard.all
    @rooms = Room.all
  end

  def create
    @user_id = params[:user_id]
    @player_name = params[:player_name]
    @password = params[:password]

    @new_player = Player.create(user_id: @user_id, player_name: @player_name, password: @password)
  end

  def sign_up
    @random_array = Array.new(10) { rand(1..9) }
    @user_id = @random_array.join('')
  end
end