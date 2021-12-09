class AddIsGameOverToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :is_game_over, :boolean
  end
end
