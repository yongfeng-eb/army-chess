class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :user_id
      t.string :player_name
      t.string :password

      t.timestamps
    end
  end
end
