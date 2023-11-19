require_relative 'building_cards'
require_relative 'resources'
class Scoring
    attr_accessor :total_score, :grid, :buildings
    def initialize(grid, building_list)
        @total_score = 0

        @grid = grid
        @buildings = building_list
        @score_type_order = ['Farm', 'Cottage', 'Church', 'Tavern', 'Theater']#, 'Well', 'Factory']
    end

    def calculate_score
        @score_type_order.each do |type|
            @buildings.each do |building|
                if building[:type] == type
                    all_of_that_building = find_on_grid(building)
                    self.public_send(building[:name].downcase.to_sym, all_of_that_building)                                   
                end
            end
        end
        # empty_spaces
        binding.pry
        @total_score
    end

    def empty_spaces
        empty = find_on_grid(Resources.empty)
        empty.each do
            @total_score = @total_score -1
        end
    end


    def find_on_grid(building)
        found = []
        @grid.grid.each do |row|
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
    end

    def farm(all_farms)
        cottages = find_on_grid(BuildingCards.cottage)
        all_farms.each do |farm|
            4.times do |i|
                feed_me = find_next_unfed_cottage(cottages)
                unless feed_me.nil?
                    feed_me[:scoring] = true
                end
            end

        end
    end

    def find_next_unfed_cottage(cottages)
        cot_to_feed = nil
        cottages.each do |cot|
            if cot.contents[:scoring]== false
                cot_to_feed = cot.contents
                break
            end
        end
        cot_to_feed
    end

    def chapel(all_chapels)
        cottages = find_on_grid(BuildingCards.cottage)
        all_chapels.each do |chapel|
            cottages.each do |cot|
                if cot.contents[:scoring]== true
                    @total_score = @total_score + BuildingCards.chapel[:point_value] 
                end
            end
        end
    end

    def tavern(all_taverns)
        possible_points = [0, 2, 5, 9, 14, 20]
        points_earned = 0
        total_taverns = all_taverns.length
        if total_taverns > 5
            points_earned = 20
        else
            points_earned = possible_points[all_taverns.length]
        end
        @total_score = @total_score + points_earned
    end

    def theater(all_theaters)
        all_theaters.each do |theater|
            row_and_col = @grid.get_row(theater.row).concat(@grid.get_col(theater.col))
            scoring_set = add_all_unique_building_types(row_and_col)
            @total_score = @total_score + scoring_set.length
        end
    end
    def add_all_unique_building_types(row_and_col)
        unique_buildings = Set.new
        row_and_col.each do |spot|
            unless spot.contents[:name] == 'empty'
                unique_buildings << spot.contents[:type]
            end
        end
        unique_buildings
    end
end