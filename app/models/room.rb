class Room < ApplicationRecord
  def self.move_first(room_id)
    begin_turn = rand(1..2)
    room = Room.find_by(room_id: room_id)
    room.next_turn = begin_turn == 1
  end

  def self.check_next_turn(room_id, move_flag)
    room = Room.find_by(room_id: room_id)
    if ((room.next_turn == true) && move_flag == 1) || ((room.next_turn == false) && move_flag.zero?)
      ''
    else
      "It's not your turn."
    end
  end

  def self.update_next_turn(room_id)
    room = Room.find_by(room_id: room_id)
    room.update(next_turn: !room.next_turn)
  end
end
