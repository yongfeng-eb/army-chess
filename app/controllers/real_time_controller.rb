class RealTimeController < ApplicationController
  # skip_before_action :require_login, only: [:playing]

  def playing
    @player_detail = params[:player_detail]
    tmp_player_detail = @player_detail.split(':')
    which_hand = tmp_player_detail[0]

    move_flag = 0
    move_flag = 1 if which_hand == 'red'

    @user_id = params[:user_id]
    @room_id = params[:room_id]


    if Room.game_over?(@room_id)
      redirect_to controller: :game_over, action: :index, user_id: @user_id
    end

    @clicked_info = ''
    @clicked_value = params[:clicked_chess].to_s
    @first_clicked_chess = params[:first_clicked_chess]

    if @clicked_value != ''
      if @first_clicked_chess.to_s == ''
        @first_clicked_chess = @clicked_value
      else
        first_clicked_chess = RealtimeInfo.get_clicked_chess(@first_clicked_chess, @room_id)
        second_clicked_chess = RealtimeInfo.get_clicked_chess(@clicked_value, @room_id)

        is_obey_rules = check_obey_rules(first_clicked_chess, second_clicked_chess, move_flag)

        if is_obey_rules != ''
          @clicked_info = is_obey_rules
          @first_clicked_chess = ''
          render_chess
          render 'real_time/playing'
        else
          @first_clicked_chess = ''
          move_chess_result = move_chess(first_clicked_chess.id, second_clicked_chess.id)
          handle_move_chess_result(move_chess_result, @room_id)
          Room.update_next_turn(@room_id)
        end
      end
    end
    render_chess
  end

  def handle_move_chess_result(result, room_id)
    if result != ''
      room = Room.find_by(room_id: room_id)
      room.update(is_game_over: true)
      win_player_id = if result == 1
                        room.red_player_id
                      else
                        room.blue_player_id
                      end
      win_hand = if result == 1
                   'red'
                 else
                   'blue'
                 end
      both_player_id = [room.red_player_id, room.blue_player_id]
      both_player_id.delete(win_player_id)
      redirect_to controller: :game_over, action: :index, user_id: win_player_id, win_player_id: win_player_id,
                  fail_player_id: both_player_id[0], room_id: room_id, win_hand: win_hand
    end
  end

  def check_obey_rules(src_chess, dst_chess, move_flag)
    if src_chess.which_hand != move_flag && src_chess.chess_id != ChessInfo.blank_space
      return 'Please move your own chess.'
    end
    return "Can't eat your own chess." if src_chess.which_hand == dst_chess.which_hand
    return "Can't move into camp occupied by other chess ." if dst_chess.position_type == 'camp' &&
                                                               dst_chess.chess_id != ChessInfo.blank_space

    next_turn = Room.check_next_turn(@room_id, move_flag)
    return next_turn if next_turn != ''

    src_chess_id = src_chess.chess_id
    case src_chess_id
    when ChessInfo.blank_space
      return "Can't move blank."
    when ChessInfo.landmine
      return "Can't move landmine."
    when ChessInfo.ensign
      return "Can't move ensign."
    end
    check_moving_rules(src_chess, dst_chess)
  end

  def check_moving_rules(src_chess, dst_chess)
    src_position_type = src_chess.position_type
    dst_position_type = dst_chess.position_type

    src_x_position = src_chess.dst_x_position
    src_y_position = src_chess.dst_y_position

    dst_x_position = dst_chess.dst_x_position
    dst_y_position = dst_chess.dst_y_position

    if src_position_type == 'railway_space' && dst_position_type == 'railway_space'
      if src_chess.chess_id == ChessInfo.engineer
        RealtimeInfo.engineer_rules(src_chess, dst_chess, @room_id.to_i)
      elsif dst_x_position == src_x_position
        return "Can't step over chess." if RealtimeInfo.blank_in_y?(@room_id.to_i, src_y_position, dst_y_position,
                                                                    src_x_position) == false

        ''
      elsif src_y_position == dst_y_position
        return "Can't step over chess." if RealtimeInfo.blank_in_x?(@room_id.to_i, src_y_position, dst_y_position,
                                                                    src_y_position) == false

        ''
      else
        "Can't move chess out of a line. (不能转弯)"
      end
    elsif (dst_x_position - src_x_position).abs ** 2 + (dst_y_position - src_y_position).abs ** 2 <= 2
      LineOfSpace.exist_line?(src_chess, dst_chess)
    else
      "Can't move over one step."
    end
  end

  def move_chess(src_id, dst_id)
    src_chess = RealtimeInfo.find src_id
    dst_chess = RealtimeInfo.find dst_id

    remain_chess = eat_rules(src_chess.chess_id, dst_chess.chess_id)

    case remain_chess
    when ''
      dst_chess.update(chess_id: ChessInfo.blank_space, which_hand: ChessInfo.blank_space_hand)
      src_chess.update(chess_id: ChessInfo.blank_space, which_hand: ChessInfo.blank_space_hand)
      ''
    when 'src'
      tmp_dst_chess_id = dst_chess.chess_id
      tmp_src_chess_hand = src_chess.which_hand
      dst_chess.update(chess_id: src_chess.chess_id, which_hand: src_chess.which_hand)
      src_chess.update(which_hand: ChessInfo.blank_space_hand, chess_id: ChessInfo.blank_space)

      if tmp_dst_chess_id == ChessInfo.ensign
        tmp_src_chess_hand
      else
        ''
      end
    when 'dst'
      src_chess.update(chess_id: ChessInfo.blank_space, which_hand: ChessInfo.blank_space_hand)
      ''
    end
  end
end

def eat_rules(src, dst)
  src_chess_priority = ChessInfo.get_chess_priority(src)
  dst_chess_priority = ChessInfo.get_chess_priority(dst)

  if (src_chess_priority == dst_chess_priority) ||
     (((src_chess_priority == ChessInfo.bomb_priority && dst_chess_priority != ChessInfo.blank_priority) ||
       dst_chess_priority == ChessInfo.bomb_priority) && dst_chess_priority != ChessInfo.ensign_priority) ||
     (src_chess_priority != ChessInfo.engineer_priority && dst_chess_priority == ChessInfo.landmine_priority)
    ''
  elsif src_chess_priority > dst_chess_priority
    'src'
  else
    'dst'
  end
end

def render_chess
  @room_id = params[:room_id]
  @realtime_info = RealtimeInfo.where(game_id: @room_id)

  @realtime_info.each do |info|
    if info.chess_id == ChessInfo.blank_space
      info.chess_id = ''
    else
      @tmp_chess_name = ChessInfo.where(chess_id: info.chess_id).pluck(:chess_name)
      info.chess_id = @tmp_chess_name[0]
    end
  end
  @element_count_inline = 0
  @vertical_count = 0
end
