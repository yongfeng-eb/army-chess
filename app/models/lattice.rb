class Lattice < ApplicationRecord
  def self.get_near_lattice_by_position(x_position, y_position)
    lattice = Lattice.find_by(x_position: x_position, y_position: y_position)
    lattice.near_lattice
  end

  def self.get_near_lattice_by_space_id(space_id)
    lattice = Lattice.find_by(space_id: space_id)
    lattice.near_lattice
  end

  def self.get_space_id_by_position(x_position, y_position)
    lattice = Lattice.find_by(x_position: x_position, y_position: y_position)
    lattice.space_id
  end

  def self.get_position_by_space_id(space_id)
    lattice = Lattice.find_by(space_id: space_id)
    "#{lattice.x_position},#{lattice.y_position}"
  end

end
