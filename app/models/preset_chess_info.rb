class PresetChessInfo < ApplicationRecord
  def self.add_camp(preset_owners_id)
    PresetChessInfo.create(preset_owners_id: preset_owners_id,
                           x_position: 1, y_position: 1,
                           chess_id: '13', is_placed: true)
    PresetChessInfo.create(preset_owners_id: preset_owners_id,
                           x_position: 3, y_position: 1,
                           chess_id: '13', is_placed: true)
    PresetChessInfo.create(preset_owners_id: preset_owners_id,
                           x_position: 2, y_position: 2,
                           chess_id: '13', is_placed: true)
    PresetChessInfo.create(preset_owners_id: preset_owners_id,
                           x_position: 1, y_position: 3,
                           chess_id: '13', is_placed: true)
    PresetChessInfo.create(preset_owners_id: preset_owners_id,
                           x_position: 3, y_position: 3,
                           chess_id: '13', is_placed: true)
    BlankSpace.update(chess_id: '13')
  end

  def self.prepare_chess(preset_owner_id)
    all_chess = AllChess.all
    all_chess.each do |chess|
      preset_chess_info = PresetChessInfo.new
      preset_chess_info.preset_owners_id = preset_owner_id
      preset_chess_info.chess_id = chess.chess_id
      preset_chess_info.x_position = -1
      preset_chess_info.y_position = -1
      preset_chess_info.is_placed = false
      preset_chess_info.save
    end
  end

  def self.placed_chess(preset_id, red_or_blue)
    if red_or_blue == 'red'
      PresetChessInfo.where(preset_owners_id: preset_id)
                     .order(y_position: :desc).order(:x_position)
    else
      PresetChessInfo.where(preset_owners_id: preset_id)
                     .order(:y_position).order(:x_position)
    end
  end

  def self.init_y_position(preset_id, room_id, red_or_blue)
    preset_chess_detail = placed_chess(preset_id, red_or_blue)
    preset_chess_detail.each do |detail|
      position_type = BlankSpace.find_by(x_position: detail.x_position, y_position: detail.y_position)
      which_hand = 1
      which_hand = 0 if red_or_blue == 'blue'
      which_hand = -1 if position_type.position_type == BlankSpace.camp_type
      RealtimeInfo.create(game_id: room_id, chess_id: detail.chess_id,
                          src_x_position: PresetChessInfo.init_value, src_y_position: PresetChessInfo.init_value,
                          dst_x_position: detail.x_position,
                          dst_y_position: transform_y_position(detail.y_position, red_or_blue),
                          position_type: position_type.position_type, which_hand: which_hand)
    end
  end

  def self.place_finish?(has_put_chess, preset_owner_id)
    if has_put_chess.split(',').length == 25
      PresetChessInfo.add_camp(preset_owner_id)
      BlankSpace.clear_placed_chess
    end
  end

  def self.transform_y_position(y_position, red_or_blue)
    if red_or_blue == 'red'
      5 - y_position
    else
      y_position + 6
    end
  end

  def self.init_value
    -1
  end

  def self.clicked_flag
    -10
  end
end
