# frozen_string_literal: true

require_relative 'resources'
require_relative 'building_shapes'
require_relative 'building_cards'


class Grid
  def initialize(size = 4, thing = Resources.empty)

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

  def place_complete_building(building_card, coords)
    place_in_grid(building_card, {row: coords[0], col: coords[1]})
  end

  def get_row(row)
    @grid[row]
  end

  def get_col(col)
    only_col = []
    @grid.each do |row|
      only_col << row[col]
    end
    only_col
  end

  def get_adjacent(row, col)
    actual_adj = []
    adj = [[(row -1),col], [(row +1), col], [row, (col -1)], [row,(col + 1)]]
    adj = remove_out_of_bounds_spots(adj)
    adj.each do |spot|
      actual_adj << @grid[spot[0]][spot[1]]
    end
    actual_adj
  end

  def remove_out_of_bounds_spots(adj)
    temp = []
    adj.each do |spot|
        unless spot[0] < 0 || spot[0] > 4
          unless spot[1] < 0 || spot[1] > 4
            temp << spot
          end
        end
    end
    temp
  end

  def test_build
    
    # place_building_shape(@shapes.cottage, [1,0])
    # # place_building_shape(@shapes.cottage, [2,0])

    # place_building_shape(@shapes.farm, [0,2])
    # # place_building_shape(@shapes.cottage.rotate_n_times(3), [1,3])

    # place_building_shape(@shapes.chapel, [3,0])
  end

  def test_scoring_fed
    place_complete_building(BuildingCards.cottage, [1,0])
    place_complete_building(BuildingCards.cottage, [2,0])
    place_complete_building(BuildingCards.cottage, [3,0])
    place_complete_building(BuildingCards.cottage, [0,0])
    place_complete_building(BuildingCards.cottage, [0,1])

    place_complete_building(BuildingCards.theater, [2,2])
    place_complete_building(BuildingCards.theater, [1,2])

    # place_complete_building(BuildingCards.tavern, [1,1])
    # place_complete_building(BuildingCards.tavern, [2,1])

    place_complete_building(BuildingCards.farm, [0,3])
    place_complete_building(BuildingCards.farm, [1,3])
    place_complete_building(BuildingCards.chapel, [2,3])
    place_complete_building(BuildingCards.chapel, [3,3])

    place_complete_building(BuildingCards.well,[0,2])
  end

  def test_taverns
    # place_complete_building(BuildingCards.tavern, [1,1])
    # place_complete_building(BuildingCards.tavern, [2,1])
    # place_complete_building(BuildingCards.tavern, [3,0])
    # place_complete_building(BuildingCards.tavern, [0,0])
    # place_complete_building(BuildingCards.tavern, [0,1])
  end

  def test_theaters

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
