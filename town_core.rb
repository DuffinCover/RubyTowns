class TownCore
    def initialize
        @town_grid = ""
        @built_buildings = []
        @buildings_list = []
        @resources = %w[R Bu Y Bk G Bn]
    end

    def place(resource, location)
        @town_grid[location] = resource
    end

    def build; end
end

class Building


    def initialize(name)
        @name = name
        @pattern = []
        @point_value = 0
        @rules_text = ""
    end

    attr_accessor :name, :pattern, :point_value, :rules_text

    def find_pattern;end

    def score;end

    
end




