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

    def place_in_grid(thing, location)
        row = location[:row].to_i
        col = location[:col].to_i
        @grid[row][col] = Square.new(row, col, thing) if @grid[row][col].contents == Resources.empty
    end

    def find_resource(resource)
        all_locations = []
        @grid.each do |row|
            row.each do |square|            
                if square.contents[:name] == resource     
                    binding.pry               
                    all_locations << [square.row, square.col]                
                end
            end
        end
        all_locations
    end

    def test_build
        place_in_grid(Resources.wheat, {row: 0, col:1})
        place_in_grid(Resources.brick,{row: 1, col: 0})
        place_in_grid(Resources.glass, {row:1, col:1})

        place_in_grid(Resources.wheat, {row: 0, col:2})
        place_in_grid(Resources.glass, {row:0, col:3})
        place_in_grid(Resources.brick,{row: 1, col: 3})

        place_in_grid(Resources.wheat, {row: 3, col:2})
        place_in_grid(Resources.glass, {row:2, col:2})
        place_in_grid(Resources.brick,{row: 2, col: 3})

        place_in_grid(Resources.wheat, {row: 3, col:1})
        place_in_grid(Resources.glass, {row:3, col:0})
        place_in_grid(Resources.brick,{row: 2, col: 0})
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