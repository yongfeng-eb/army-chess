class Player < ApplicationRecord
  has_one :leader_board, dependent: :destroy
end
