class CreatePlayerIsPlayings < ActiveRecord::Migration[6.1]
  def change
    create_table :player_is_playings do |t|
      t.boolean :player_status

      t.timestamps
    end
  end
end
