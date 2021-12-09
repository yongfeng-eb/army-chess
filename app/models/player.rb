class Player < ApplicationRecord
  has_one :leader_board, dependent: :destroy
  has_one :player_is_playing, dependent: :destroy

  has_many :preset_owners

  def self.get_name_by_id(id)
    player = Player.find_by(user_id: id)
    player.player_name
  end

  def self.get_password_by_id(id)
    player = Player.find_by(user_id: id)
    player.password
  end

end
