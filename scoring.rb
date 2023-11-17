require_relative 'building_cards'
class Scoring
    attr_accessor :total_score, :grid, :buildings
    def initialize(grid, building_list)
        @total_score = 0
        @grid = grid
        @buildings = building_list
        @score_type_order = ['Farm', 'Cottage', 'Church']#, 'Tavern', 'Theater', 'Well', 'Factory']
    end

    def calculate_score
        cottages = find_on_grid(BuildingCards.cottage)
        @score_type_order.each do |type|
            @buildings.each do |building|
                if building[:type] == type
                    self.public_send(building[:name].downcase.to_sym, cottages)
                end
                # find all of that kind of building
                # calculate that building's score
                # add that to total
            end
        end
        binding.pry
        # return total
    end

    def find_on_grid(building)
        found = []
        @grid.each do |row|
            row.each do |col|           
                if col.contents[:name] == building[:name]
                    found << col
                end
            end
        end
        found
    end

    def cottage(cottages)
        cottages.each do |cot|
            if cot.contents[:scoring]== true
                @total_score = @total_score + cot.contents[:point_value] 
            end
        end
        binding.pry
    end

    def farm(cottages)
        4.times do |i|
            unless cottages[i].nil?
                unless cottages[i].contents[:scoring] == true
                    cottages[i].contents[:scoring] = true
                end
            end
        end
    end

    def chapel(cottages)
        cottages.each do |cot|
            if cot.contents[:scoring]== true
                @total_score = @total_score + BuildingCards.chapel[:point_value] 
            end
        end
    end
end