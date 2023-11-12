class TownCore
    def initialize
        @town_grid = [%w[x x x x], %w[x x x x], %w[x x x x], %w[x x x x]]
        @built_buildings = []
        @buildings_list = ['Cottage']
        @resources = %w[R U Y B G Bn]
    end

    attr_accessor :town_grid, :built_buildings, :buildings_list, :resources

    def show_grid
        puts "  | 1 | 2 | 3 | 4 |"
        puts "-------------------"
        row_num = 1
        @town_grid.each do |row|
        
            line = "#{row_num} | "
            row.each do |square|
                line += square + " | "
            end
            row_num = row_num +1
            puts line
            puts "-------------------"
        end
        puts "\n"
    end

    def add_building(building_Card)
        @buildings_list.append(building_Card)
    end

    def place(resource, location)
        @town_grid[location[:row].to_i][location[:col].to_i] = resource
        show_grid
    end

    def location_coords(x, y)
        {
            row: y.to_i-1, 
            col: x.to_i-1
        }
    end

    def build; end

    def permute(pattern)
        length = pattern.size
        pattern.chars.to_a.permutation.map(&:join)
    end
end

class Building


    def initialize(card)
        @name = card[:name]
        @pattern = card[:pattern]
        @point_value = card[:point_value]
        @rules_text = card[:score_condition]
    end

    attr_accessor :name, :pattern, :point_value, :rules_text

    def find_pattern;end

    def score;end

    
end




