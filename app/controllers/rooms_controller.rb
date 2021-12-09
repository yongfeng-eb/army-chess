class RoomsController < ApplicationController
  def create
    random_array = Array.new(6) { rand(1..9) }
    @room_id = random_array.join('')

    @create_room_player_id = params[:create_room_player_id]
    tmp_red_player = Player.find_by(user_id: @create_room_player_id)
    red_player_name = tmp_red_player.player_name

    room = Room.create(room_id: @room_id,
                       red_player_name: red_player_name, blue_player_name: '',
                       red_player_id: @create_room_player_id, blue_player_id: '',
                       room_status: true, is_game_over: false)
    room.update(next_turn: Room.move_first(@room_id))
  end
end
