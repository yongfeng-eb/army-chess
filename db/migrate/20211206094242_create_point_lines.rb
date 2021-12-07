class CreatePointLines < ActiveRecord::Migration[6.1]
  def change
    create_table :point_lines do |t|
      t.integer :point_id
      t.integer :x_position
      t.integer :y_position
      t.string :near_point

      t.timestamps
    end
  end
end
