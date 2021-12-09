class CreateLattices < ActiveRecord::Migration[6.1]
  def change
    create_table :lattices do |t|
      t.integer :space_id
      t.integer :x_position
      t.integer :y_position
      t.string :near_lattice

      t.timestamps
    end
  end
end
