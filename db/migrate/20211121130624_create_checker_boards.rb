class CreateCheckerBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :checker_boards do |t|
      t.integer :space_type
      t.string :space_name
      t.integer :x_position
      t.integer :y_position

      t.timestamps
    end
  end
end
