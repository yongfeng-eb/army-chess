class RealtimeInfo < ApplicationRecord

  def self.get_clicked_chess(clicked_value, game_id)
    tmp_clicked_chess = clicked_value.split(',')
    x_position = tmp_clicked_chess[0].to_i
    y_position = tmp_clicked_chess[1].to_i
    RealtimeInfo.find_by(game_id: game_id, dst_x_position: x_position, dst_y_position: y_position)
  end

  def self.blank_in_x?(game_id, src, dst, no_change_value)
    middle_part_chess = RealtimeInfo.where(game_id: game_id)
                                    .where(dst_y_position: no_change_value)
                                    .where("dst_x_position > #{[src, dst].min}")
                                    .where("dst_x_position < #{[src, dst].max}")
                                    .pluck(:chess_id)
    middle_part_chess.each do |chess_id|
      return false if chess_id != ChessInfo.blank_space
    end
    true
  end

  def self.blank_in_y?(game_id, src, dst, no_change_value)
    middle_part_chess = RealtimeInfo.where(game_id: game_id)
                                    .where(dst_x_position: no_change_value)
                                    .where("dst_y_position > #{[src, dst].min}")
                                    .where("dst_y_position < #{[src, dst].max}")
                                    .pluck(:chess_id)
    middle_part_chess.each do |chess_id|
      puts chess_id == ChessInfo.blank_space
      return false if chess_id != ChessInfo.blank_space
    end
    true
  end
end
