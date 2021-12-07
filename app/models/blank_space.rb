class BlankSpace < ApplicationRecord
  def self.clear_placed_chess
    BlankSpace.update(chess_id: '13')
  end

  def self.landmine_min_y
    4
  end

  def self.base_camp_type
    'base_camp'
  end

  def self.camp_type
    'camp'
  end
end
