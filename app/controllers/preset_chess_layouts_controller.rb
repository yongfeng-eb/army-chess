class PresetChessLayoutsController < ApplicationController
  def choose
    @room_id = params[:room_id]
    @create_room_player_id = params[:create_room_player_id]
    @join_room_player_id = params[:join_room_player_id]

    unless @join_room_player_id.nil?
      blue_player_name = Player.find_by(user_id: @join_room_player_id)
      current_room = Room.find_by(room_id: @room_id)
      current_room.update(blue_player_name: blue_player_name.player_name, room_status: false)
    end

    @which_hand = params[:which_hand]
    @player_detail = if @which_hand.to_s == 'red_hand'
                       "red:#{@create_room_player_id}"
                     else
                       "blue:#{@join_room_player_id}"
                     end

    current_player_id = if @create_room_player_id.nil?
                          @join_room_player_id
                        else
                          @create_room_player_id
                        end

    player = Player.find_by(user_id: current_player_id)
    @own_preset_ids = PresetOwner.where(players_id: player.id).pluck(:preset_id)
  end

  def prepared
    @user_id = params[:user_id]

    @room_id = params[:room_id]
    @player_detail = params[:player_detail]
    @chosen_preset_id = params[:chosen_preset_id]

    @red_or_blue = @player_detail.split(':')[0]

    PresetChessInfo.init_y_position(@chosen_preset_id.to_i, @room_id.to_i, @red_or_blue)
  end
end
