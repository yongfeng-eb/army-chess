class ChessInfo < ApplicationRecord

  def self.get_chess_priority(chess_id)
    chess = ChessInfo.find_by(chess_id: chess_id)
    chess.chess_priority
  end

  def self.bomb
    '10'
  end

  def self.landmine
    '11'
  end

  def self.ensign
    '12'
  end

  def self.blank_space
    '13'
  end

  def self.engineer
    '9'
  end

  def self.bomb_priority
    2
  end

  def self.ensign_priority
    0
  end

  def self.landmine_priority
    1
  end

  def self.engineer_priority
    3
  end

  def self.red_hand
    1
  end

  def self.blue_hand
    0
  end

  def self.blank_space_hand
    -1
  end

end
