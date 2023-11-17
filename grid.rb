# frozen_string_literal: true

require_relative 'resources'
require_relative 'building_shapes'


class Grid
  def initialize(size, thing)

    @resources = Resources.all_resources
    @shapes = BuildingShapes.new
    @size = size
    @grid = []
    size.times do
      @grid << []
    end
    @grid.each_with_index do |row, idx|
      @size.times do |col|
        row << Square.new(idx, col, thing)
      end
    end
  end
  attr_accessor :size, :grid

  def reset_square(row, col)
    @grid[row][col] = Square.new(row, col, Resources.empty)
  end

  def place_in_grid(thing, location)
    row = location[:row].to_i
    col = location[:col].to_i
    @grid[row][col] = Square.new(row, col, thing) if @grid[row][col].contents == Resources.empty
  end

  def find_resource(resource)
    all_locations = []
    @grid.each do |row|
      row.each do |square|
        all_locations << [square.row, square.col] if square.contents[:name] == resource
      end
    end
    all_locations
  end

  def place_building_shape(shape, start)
    row = start[0]
    col = start[1]
    place_in_grid(@resources[shape.name.to_sym], {row:row, col:col})
    next_thing = shape.next_directions
    if next_thing[0].nil?
      return
    end
    next_thing.each do |thing|
      directions = thing[:direction]
      next_space = shape.next_place(directions, start)
      shape = thing[:thing]
      place_building_shape(shape, next_space)
    end
  end

  def test_build
    place_building_shape(@shapes.cottage, [1,0])

    place_building_shape(@shapes.farm, [0,2])
    # place_building_shape(@shapes.cottage.rotate_n_times(3), [1,3])

    place_building_shape(@shapes.chapel, [3,0])
  end

  #-----------------------Scoring------------------------------------

end

class Square
  def initialize(row, col, thing)
    @row = row
    @col = col
    @contents = thing
  end
  attr_accessor :row, :col, :contents
end
