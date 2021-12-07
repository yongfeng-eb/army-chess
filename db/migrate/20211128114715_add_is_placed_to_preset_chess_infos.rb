class AddIsPlacedToPresetChessInfos < ActiveRecord::Migration[6.1]
  def change
    add_column :preset_chess_infos, :is_placed, :boolean
  end
end
