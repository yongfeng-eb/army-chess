class CreateChessInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :chess_infos do |t|
      t.string :chess_id
      t.string :chess_name
      t.integer :chess_priority

      t.timestamps
    end
  end
end
