class BuildingShapes
    def glass
        Shape.new('glass')
    end

    def brick
        Shape.new('brick')
    end

    def wood
        Shape.new('wood')
    end

    def wheat
        Shape.new('wheat')
    end

    def stone
        Shape.new('stone')
    end




    def normal_cottage
        br = brick
        gl = glass
        wh = wheat
        br.add_right(gl)
        gl.add_up(wh)
        br
    end
end

class Shape
   
    attr_accessor :name, :up, :down, :left, :right
    
    def initialize(material)
        @name = material
        @up= {direction: 'up', thing: nil}
        @down= {direction: 'down', thing: nil}
        @left= {direction: 'left', thing: nil}
        @right= {direction: 'right', thing: nil}
    end


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

    
    def next_directions
        non_nil_directions = []
        all_directions = [@up, @down, @left, @right]
        all_directions.each do |direction|
            if direction[:thing].nil?
                next
            else
                non_nil_directions << direction    
            end
        end
        non_nil_directions
    end

    def next_place(direction, coords)
        row = coords[0]
        col  = coords[1]
        case direction
        when 'up'
            row = row -1
        when 'down'
            row = row +1
        when 'left'
            col = col-1
        when 'right'
            col = col+1
        else
            puts 'you shouldnt be here'
        end
        [row, col]
    end
end