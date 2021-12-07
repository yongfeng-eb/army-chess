class PresetPositionsController < ApplicationController
  def create
    @has_put_chess = params[:has_put_chess]
    @info_flag = ''
    @current_player_id = params[:user_id]
    @preset_owner_id = params[:preset_owner_id]

    if !params[:first_access].nil?
      # first access
      @has_put_chess = ''
      user_id = params[:user_id]
      player = Player.find_by(user_id: user_id)
      new_preset = PresetOwner.create(players_id: player.id)
      @preset_owner_id = new_preset.id
      new_preset.update(preset_id: @preset_owner_id)
      PresetChessInfo.prepare_chess(new_preset.preset_id)
    else
      first_clicked_chess = params[:clicked_chess]
      if !first_clicked_chess.nil?
        # handle first click
        tmp_first_clicked_chess = PresetChessInfo.find(first_clicked_chess)
        @first_clicked_chess_id = tmp_first_clicked_chess.id
      else
        # handle second click
        first_clicked_chess = PresetChessInfo.find(params[:first_clicked_chess].to_i)
        second_clicked_space = clicked_space_button
        is_obey_rules = check_conform_rules(first_clicked_chess, second_clicked_space)

        if is_obey_rules != ''
          @info_flag = is_obey_rules
          @first_clicked_chess_id = ''
        else
          first_clicked_chess.update(x_position: second_clicked_space.x_position,
                                     y_position: second_clicked_space.y_position,
                                     is_placed: true)
          second_clicked_space.update(chess_id: first_clicked_chess.chess_id)
          @has_put_chess += "#{first_clicked_chess.id},"

        end
      end
      PresetChessInfo.place_finish?(@has_put_chess, @preset_owner_id)
    end

    render_place_chess
  end
end

def check_conform_rules(first_button, second_button)
  if first_button.chess_id == ChessInfo.landmine && second_button.y_position < BlankSpace.landmine_min_y
    '地雷只能放在最后两行'
  elsif first_button.chess_id == ChessInfo.ensign && second_button.position_type != BlankSpace.base_camp_type
    '军旗只能放在大本营'
  elsif second_button.position_type == BlankSpace.camp_type
    '行营中不能放棋子'
  else
    ''
  end
end

def clicked_space_button
  clicked_space_position = params[:put_chess_position]
  tmp_position = clicked_space_position.split(',')
  clicked_space_x_position = tmp_position[0]
  clicked_space_y_position = tmp_position[1]

  BlankSpace.find_by(x_position: clicked_space_x_position.to_i,
                     y_position: clicked_space_y_position.to_i)
end

def render_place_chess
  @all_preset_chess = PresetChessInfo.where(preset_owners_id: @preset_owner_id)
  @all_preset_chess.each do |chess|
    tmp_chess = ChessInfo.find_by(chess_id: chess.chess_id)
    chess.chess_id = tmp_chess.chess_name
  end

  @all_blank_space = BlankSpace.all
  @all_blank_space.each do |space|
    tmp_space = ChessInfo.find_by(chess_id: space.chess_id)
    space.chess_id = tmp_space.chess_name
  end

  @element_count_inline = 0
  @vertical_count = 0
end