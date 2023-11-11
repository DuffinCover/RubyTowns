class TownCore
    def initialize
        @town_grid = [%w[x x x x], %w[x x x x], %w[x x x x], %w[x x x x]]
        @built_buildings = []
        @buildings_list = []
        @resources = %w[R Bu Y Bk G Bn]
    end

    attr_accessor :town_grid, :built_buildings, :buildings_list, :resources

    def add_building(building_Card)
        @buildings_list.append(building_Card)
    end

    def place(resource, location)
        @town_grid[location] = resource
    end

    def build; end
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




