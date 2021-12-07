class CreatePresetChessInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :preset_chess_infos do |t|
      t.belongs_to :preset_owners, index: true, foreign_key: true

      t.string :chess_id
      t.integer :x_position
      t.integer :y_position

      t.timestamps
    end
  end
end
