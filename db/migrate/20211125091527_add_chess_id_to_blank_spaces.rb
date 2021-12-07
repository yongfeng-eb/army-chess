class AddChessIdToBlankSpaces < ActiveRecord::Migration[6.1]
  def change
    add_column :blank_spaces, :chess_id, :string
  end
end
