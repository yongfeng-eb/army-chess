class AddRedPlayerIdToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :red_player_id, :string
    add_column :rooms, :blue_player_id, :string
  end
end
