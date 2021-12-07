class CreateRealtimeInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :realtime_infos do |t|
      t.integer :game_id
      t.string :chess_id
      t.integer :src_x_position
      t.integer :src_y_position
      t.integer :dst_x_position
      t.integer :dst_y_position
      t.string :position_type
      t.integer :which_hand

      t.timestamps
    end
  end
end
