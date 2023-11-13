# frozen_string_literal: true
require 'regex'

class BuildingCards
  def self.cottage
    # normal
    # xYxxRU

    # rotated right 90
    # RxxxBY

    # rotated right 180
    # URxxYx

    # rotated right 270
    # YUxxxR
    {
      name: 'Cottage',
      point_value: 3,
      resources_need: %w[brick glass wheat],
      patterns: [%r{.[t].{2}[b][g]}, %r{[b].{3}[g][t]}, %r{[g][b].{2}[t].}, %r{[t][g].{3}[b]}],
      shapes: {
        up: Shape.new('brick').add_right(Shape.new('glass').add_up(Shape.new('wheat'))),
        # ninety: "",
        # one_eighty: "",
        # two_seventy: ""
      }
    }
  end
end




class Shape
    def initialize(material)
        @name = material
        @up= {name: 'up', thing: nil}
        @down= {name: 'down', thing: nil}
        @left= {name: 'left', thing: nil}
        @right= {name: 'right', thing: nil}
    end
attr_accessor :name, :neighbors
    def add_up(shape)
        @up[:thing] = shape if @up[:thing].nil?
    end

    def add_down(shape)
        @down[:thing] = shape if @down[:thing].nil?
    end

    def add_left(shape)
        @left[:thing] = shape if @left[:thing].nil?
    end

    def  add_right(shape)
        @right[:thing] = shape if @right[:thing].nil?
    end

    def check_neighbors(thing, init_row, init_col)
        directions = [@up, @down, @left, @right]
        directions.each do |direction|
            if direction[:thing].nil?
                continue
                #find the non_nil_path
            else
                new_thing_location = next_place(direction[:name], thing)
            end
        end
    end

    def next_place(name, thing)
        binding.pry
        case name
        when 'up'
            thing[:row] = thing[:row]-1
        when 'down'
            thing[:row] = thing[:row]+1
        when 'left'
            thing[:col] = thing[:col]-1
        when 'right'
            thing[:col] = thing[:col]+1
        else
            thing
        end
        thing
    end

    # def rotate_right
    #     temp = Shape.new(@name)


    #     self=temp
    # end

    # def rotate_left
    #     temp = Shape.new(@name)
    #     self=temp
    # end

    # def rotate_half
    #     temp = Shape.new(@name)

    #     self=temp
    # end
end
# YBxx
# xRxx
# xxxx
# xxxx
