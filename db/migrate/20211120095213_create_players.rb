class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :user_id
      t.string :player_name
      t.string :password

      t.timestamps
    end

    create_table :leader_boards do |t|
      t.belongs_to :player

      t.integer :win_count
      t.integer :lose_count
      t.integer :total_count

      t.timestamps
    end
  end
end
