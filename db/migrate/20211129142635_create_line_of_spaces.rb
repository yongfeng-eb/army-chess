class CreateLineOfSpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :line_of_spaces do |t|
      t.integer :one_x_position
      t.integer :one_y_position
      t.integer :two_x_position
      t.integer :two_y_position
      t.boolean :is_connected

      t.timestamps
    end
  end
end
