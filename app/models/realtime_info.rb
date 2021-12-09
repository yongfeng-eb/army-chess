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
      return false if chess_id != ChessInfo.blank_space
    end
    true
  end

  def self.engineer_rules(src_chess, dst_chess, room_id)
    src_x_position = src_chess.dst_x_position
    src_y_position = src_chess.dst_y_position

    @final_x_position = dst_chess.dst_x_position
    @final_y_position = dst_chess.dst_y_position
    @final_chess_id = dst_chess.chess_id

    tmp_near_lattice = Lattice.get_near_lattice_by_position(src_x_position, src_y_position)

    wait_access_lattices = tmp_near_lattice.split(',')
    visited_lattices = [Lattice.get_space_id_by_position(src_x_position, src_y_position).to_s]

    rules(room_id, wait_access_lattices, visited_lattices)

  end

  def self.rules(room_id, wait_access_lattices, visited_lattices)
    if wait_access_lattices.empty?
      return 'Can not get to.'
    else
      current_lattice = wait_access_lattices[-1]
      chess = RealtimeInfo.get_chess_by_space_id(current_lattice, room_id)
      if chess.dst_x_position == @final_x_position && chess.dst_y_position == @final_y_position
        return ''
      elsif chess.chess_id != '13' && wait_access_lattices.empty?
        return 'There is another chess in the road.'
      end
    end

    wait_access_lattices.pop
    visited_lattices.append(current_lattice)

    if chess.chess_id == '13'
      near_lattice = Lattice.get_near_lattice_by_space_id(current_lattice)
      near_lattice.split(',').each do |lattice|
        wait_access_lattices.push(lattice) unless visited_lattices.include?(lattice)
      end
    end

    rules(room_id, wait_access_lattices, visited_lattices)
  end

  def self.get_chess_by_position(x_position, y_position, room_id)
    RealtimeInfo.find_by(dst_x_position: x_position, dst_y_position: y_position, game_id: room_id)
  end

  def self.get_chess_by_space_id(space_id, room_id)
    lattice_position = Lattice.get_position_by_space_id(space_id)
    x_position = lattice_position.split(',')[0]
    y_position = lattice_position.split(',')[1]
    RealtimeInfo.get_chess_by_position(x_position, y_position, room_id)
  end

end
