require 'colorize'
require 'colorized_string'
require 'regex'
require_relative 'resources'
require_relative 'building_cards'
require_relative 'easy_starting_point'
require_relative 'grid'


class TownCore
  def initialize
    puts String.colors
    # @town_grid = StartingPoint.cottage_build
    @town_grid = Grid.new(4, Resources.empty)
    @town_grid.test_build
    @built_buildings = []
    @buildable = []
    @buildings_list = [BuildingCards.cottage]
    @resources = Resources.all_resources
  end

  attr_accessor :town_grid, :built_buildings, :buildings_list, :resources

  def show_grid
    system('clear')
    system('cls')
    puts '  |  1 |  2 |  3 |  4 |'
    puts '-----------------------'.colorize(:green)
    row_num = 1
    @town_grid.grid.each do |row|
      line = "#{row_num}" + ' | '.colorize(:green)
      row.each do |square|      
        line += square.contents[:print] + ' | '.colorize(:green)
      end
      row_num += 1
      puts line
      puts '-----------------------'.colorize(:green)
    end
    puts "\n"
  end

  def reset_grid
    @town_grid = [[], [], [], []]
    @town_grid.each do |row|
      empty = Resources.empty
      4.times do
        row << empty
      end
    end
  end

  def add_building(building_Card)
    @buildings_list.append(building_Card)
  end

  def place(resource, location)  
    @town_grid.place_in_grid(resource, location)
    show_grid
  end

  def location_coords(location)
    {
      row: location[:row].to_i - 1,
      col: location[:col].to_i - 1
    }
  end

  def build
    current_town = generate_town_string
    binding.pry
    @buildings_list.each do |building|
      patterns = building[:patterns]
      patterns.each do |pattern|      
        binding.pry
        @buildable << building if current_town.match(Regex.new(pattern))
      end
    end
    binding.pry
    @buildable.each do |building|
      locations = locate_resources_for_building(building)      
    end
  end

  def locate_resources_for_building(building)
    resource_locations = {}
    building[:resources_need].each do |resource|
      locations = @town_grid.find_resource(resource)
      resource_locations[resource] = locations
    end
    resource_locations
  end


  def generate_town_string
    town_string = ''
    @town_grid.grid.each do |row|
      row.each do |piece|      
        town_string << piece.contents[:piece]
      end
    end
    town_string
  end
end

# class Building

#     def initialize(card)
#         @name = card[:name]
#         @pattern = card[:pattern]
#         @point_value = card[:point_value]
#         @rules_text = card[:score_condition]
#     end

#     attr_accessor :name, :pattern, :point_value, :rules_text

#     def find_pattern;end

#     def score;end

# end
