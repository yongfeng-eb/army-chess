class LineOfSpace < ApplicationRecord
  def self.exist_line?(src_chess, dst_chess)
    src_x_position = src_chess.dst_x_position
    src_y_position = src_chess.dst_y_position

    dst_x_position = dst_chess.dst_x_position
    dst_y_position = dst_chess.dst_y_position

    first_line = LineOfSpace.find_by(one_x_position: src_x_position, one_y_position: src_y_position, two_x_position:
      dst_x_position, two_y_position: dst_y_position)
    second_line = LineOfSpace.find_by(one_x_position: dst_x_position, one_y_position: dst_y_position, two_x_position:
      src_x_position, two_y_position: src_y_position)

    if !first_line.nil? || !second_line.nil?
      '不能走没有线相连的格子'
    else
      ''
    end
  end
end
