require 'colorize'
require 'colorized_string'
require 'regex'
require_relative 'resources'
require_relative 'building_cards'
require_relative 'easy_starting_point'
require_relative 'grid'
require_relative 'building_shapes'
require 'set'


class TownCore
  def initialize
    # @town_grid = StartingPoint.cottage_build
    @town_grid = Grid.new(4, Resources.empty)
    @town_grid.test_build
    @built_buildings = []
    @buildable = []
    @buildings_list = [BuildingCards.cottage]
    @resources = Resources.all_resources
    @remove_for_building = []
  end

  attr_accessor :town_grid, :built_buildings, :buildings_list, :resources, :remove_for_building

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
    @town_grid = Grid.new(4, Resources.empty)
    @built_buildings = []
    @buildable = []
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
    choices = []
    find_all_buildable_buildings
    @buildable.each do |building|
        human_locale = []
        building.build_spots.each do |spot|
            coord = []
            coord[0] = spot[0] +1
            coord[1] = spot[1] +1
            human_locale << coord
        end
        choice = building.name+" #{building.number}" + " #{human_locale}"
        choices << choice
    end
    choices
  end


  def find_all_buildable_buildings
    total_options = 0
    @buildings_list.each do |building|
      resource_locations = locate_resources_for_building(building)
      shape_list = building[:shapes]

      shape_list.each do |direction, thing|  
        resource_locations[thing.name].each do |start|
            valid_build = Set.new 
            check_neighbors(thing, start, resource_locations, valid_build)
            if valid_build.size == building[:total_pieces]
                total_options = total_options +1
                @buildable << Building.new(building[:name], valid_build.to_a, total_options)
            end
        end
      end
    end
  end


  def check_neighbors(resource, start, coords, valid_build)
    valid_build << start
    next_direction = resource.next_directions
    if next_direction[0].nil?
        return
    end
    next_direction.each do |direction|        
        next_coord = resource.next_place(direction[:direction], start)
        if coords[direction[:thing].name].include? next_coord
            check_neighbors(direction[:thing], next_coord, coords, valid_build)          
        end
    end
    valid_build
  end



  def locate_resources_for_building(building)
    resource_locations = {}
    building[:resources_need].each do |resource|
      locations = @town_grid.find_resource(resource)
      resource_locations[resource] = locations
    end
    resource_locations
  end

  def highlight_choice(selection)
    number = selection.split(' ')[1].to_i
    @buildable.each do |build|
        if build.number == number
            choices = []
            build.build_spots.each do |coord|
                row = coord[0]
                col = coord[1]
                @remove_for_building << @town_grid.grid[row][col]
                @town_grid.reset_square(row, col)
                @town_grid.place_in_grid(BuidlingColors.all_buildings[build.name.to_sym], {row: row, col:col})
                choices << "#{[coord[0]+1, coord[1]+1]}"
            end
            return choices 
        end
    end
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

class Building

    def initialize(name, build_spot, number)
        @name = name
        @build_spots = build_spot
        @number = number
    end
    attr_accessor :name, :build_spots, :number

end


# OLD BUILD DIRECTION
    # current_town = generate_town_string
    # @buildings_list.each do |building|
    #   patterns = building[:patterns]
    #   patterns.each do |pattern|
    #     @buildable << building if pattern.match(current_town)
    #   end
    # end
    # @buildable.each do |building|
    #   locations = locate_resources_for_building(current_town, building)
    # end
    # @buildable