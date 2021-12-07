class CreateBlankSpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :blank_spaces do |t|
      t.integer :x_position
      t.integer :y_position
      t.string :position_type

      t.timestamps
    end
  end
end
