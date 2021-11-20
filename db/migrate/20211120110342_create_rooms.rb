class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :room_id
      t.string :red_player_name
      t.string :blue_player_name
      t.boolean :room_status

      t.timestamps
    end
  end
end
