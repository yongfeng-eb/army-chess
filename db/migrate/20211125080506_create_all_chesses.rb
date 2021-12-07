class CreateAllChesses < ActiveRecord::Migration[6.1]
  def change
    create_table :all_chesses do |t|
      t.string :chess_id
      t.string :chess_name

      t.timestamps
    end
  end
end
