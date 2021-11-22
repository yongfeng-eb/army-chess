class Player < ApplicationRecord
  has_one :leader_board, dependent: :destroy
  has_one :player_is_playing, dependent: :destroy
end
