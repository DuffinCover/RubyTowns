require_relative 'building_cards'
require_relative 'resources'
class Scoring
    attr_accessor :total_score, :grid, :buildings
    def initialize(grid, building_list)
        @total_score = 0
        @grid = grid
        @buildings = building_list
        @score_type_order = ['Farm', 'Cottage', 'Church', 'Tavern', 'Theater', 'Well']#, 'Factory']
    end

    def calculate_score
        buildings_by_type = group_all_buildings
        @score_type_order.each do |type|
            chosen_building = buildings_by_type[type]
            unless chosen_building.nil?
                building_name = chosen_building[0].contents[:name]              
                self.public_send(building_name.downcase.to_sym, chosen_building)  
            end
          
        end
        empty_spaces
        @total_score
    end

    def group_all_buildings
        all_buildings = {}
        @grid.grid.each do |row|
            row.each do |col|
                if all_buildings[col.contents[:type]].nil?
                    all_buildings[col.contents[:type]] = []
                end
                all_buildings[col.contents[:type]] << col
            end
        end
        all_buildings
    end

    def empty_spaces
        names = all_building_names
        @grid.grid.each do |row|
            row.each do |col|
                unless names.include?(col.contents[:name])
                    @total_score = @total_score -1
                end
            end
        end
    end

    def all_building_names
        names = []
        @buildings.each do |building|
            names << building[:name]
        end
        names
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
                    @total_score = @total_score + chapel.contents[:point_value] 
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
        names = all_building_names
        all_theaters.each do |theater|          
            row  = @grid.get_row(theater.row)
            col = @grid.get_col(theater.col)
            scoring_set  = add_all_unique_building_types([row, col], names)
            @total_score = @total_score + scoring_set.length
        end
    end
    def add_all_unique_building_types(row_and_col, names)
        unique_buildings = Set.new     
        row_and_col.each do |row_or_col|
            row_or_col.each do |spot|                
                if names.include? (spot.contents[:name])
                    unique_buildings << spot.contents[:type]
                end
            end
        end
        unique_buildings
    end

    def well(all_wells)
        all_wells.each do |well|
            neighbors = @grid.get_adjacent(well.row, well.col)
            neighbors.each do |neighbor|
                if neighbor.contents[:name] == 'cottage'
                    @total_score = @total_score + well.contents[:point_value] 
                end
            end
        end
    end
end