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

    def cottage_right
        br = brick
        gl = glass
        wh = wheat

        br.add_down(gl)
        gl.add_right(wh)
        br
    end

    def chapel
        br1 = brick
        br2 = brick
        gl = glass
        wh = wheat

        wh.add_down(gl)
        gl.add_right(br1)
        gl.add_left(br2)
        wh
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

    def rotate(times)
        temp_shape = self.clone
        recursive_rotate(temp_shape)
        # literaly just recurse the same way you follow the shape
        # update the direction via case?
    end

    def recursive_rotate(shape)
        next_direction = shape.next_directions
        if next_direction[0].nil?
            return
        end
        next_direction.each do |direction|
            next_shape = direction[:thing]
            rotate_direction(direction[:direction], shape)
            recursive_rotate(next_shape)
        end
        binding.pry
        shape
    end

    def rotate_direction(direction, shape)
        case direction
        when 'up'
            # up -> right
            shape.right[:thing] = shape.up[:thing]
            shape.up[:thing] = nil
        when 'down'
            # down -> left
            shape.left[:thing] = shape.down[:thing]
            shape.down[:thing] = nil
        when 'left'
            # left -> up
            shape.up[:thing] = shape.left[:thing]
            shape.left[:thing] = nil
        when 'right'
            # right -> down
            shape.down[:thing] = shape.right[:thing]
            shape.right[:thing] = nil
        else
            puts 'you shouldnt be here'
        end
        shape
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