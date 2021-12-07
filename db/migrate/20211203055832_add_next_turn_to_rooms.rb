class AddNextTurnToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :next_turn, :boolean
  end
end
