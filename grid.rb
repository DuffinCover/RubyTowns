# frozen_string_literal: true

require_relative 'resources'

class Grid
  def initialize(size, thing)
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

  def test_build
    place_in_grid(Resources.wheat, { row: 0, col: 1 })
    place_in_grid(Resources.brick, { row: 1, col: 0 })
    place_in_grid(Resources.glass, { row: 1, col: 1 })
    #
    # place_in_grid(Resources.wheat, {row: 0, col:3})
    # place_in_grid(Resources.brick, {row:1, col: 2})
    # place_in_grid(Resources.glass, {row:1, col:3})

    place_in_grid(Resources.wheat, { row: 0, col: 2 })
    place_in_grid(Resources.glass, { row: 0, col: 3 })
    place_in_grid(Resources.brick, { row: 1, col: 3 })

    # place_in_grid(Resources.wheat, {row: 2, col:2})
    # place_in_grid(Resources.glass, {row: 3, col:2})
    # place_in_grid(Resources.brick, {row: 3, col:1})
    # place_in_grid(Resources.brick, {row: 3, col:3})

    place_in_grid(Resources.wheat, { row: 3, col: 2 })
    place_in_grid(Resources.glass, { row: 2, col: 2 })
    place_in_grid(Resources.brick, { row: 2, col: 3 })

    place_in_grid(Resources.wheat, { row: 3, col: 1 })
    place_in_grid(Resources.glass, { row: 3, col: 0 })
    place_in_grid(Resources.brick, { row: 2, col: 0 })
  end

  def find_building(building)
    building[:resources_need]
  end
end

class Square
  def initialize(row, col, thing)
    @row = row
    @col = col
    @contents = thing
  end
  attr_accessor :row, :col, :contents
end
