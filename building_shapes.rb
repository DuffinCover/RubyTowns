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

  def abbey
    br = brick
    st1 = stone
    st2 = stone
    gl = glass

    br.add_right(st1)
    st1.add_right(st2)
    st2.add_up(gl)
    br
  end

  
  def bakery
    br1 = brick
    br2 = brick
    gl = glass
    wh = wheat

    wh.add_down(gl)
    gl.add_right(br1)
    gl.add_left(br2)
    wh
  end

  def chapel
    st1 = stone
    gl1 = glass
    st2 = stone
    gl2 = glass
    st1.add_right(gl1)
    gl1.add_right(st2)
    st2.add_up(gl2)
    st1
  end

  def cloister
    wd = wood
    br = brick
    st = stone
    gl = glass

    wd.add_right(br)
    br.add_right(st)
    st.add_up(gl)
    wd

  end

  def cottage
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
    @up = { direction: 'up', thing: nil }
    @down = { direction: 'down', thing: nil }
    @left = { direction: 'left', thing: nil }
    @right = { direction: 'right', thing: nil }
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

  def add_right(shape)
    @right[:thing] = shape if @right[:thing].nil?
  end

  def rotate
    temp_shape = clone
    shape = recursive_rotate(temp_shape)
    # literaly just recurse the same way you follow the shape
    # update the direction via case?
  end

  def recursive_rotate(shape)
    next_direction = shape.next_directions
    return if next_direction[0].nil?

    next_direction.each do |direction|
      next_shape = direction[:thing]
      rotate_direction(direction[:direction], shape)
      recursive_rotate(next_shape)
    end
    # binding.pry
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
      next if direction[:thing].nil?


      non_nil_directions << direction
    end
    non_nil_directions
  end

  def next_place(direction, coords)
    row = coords[0]
    col  = coords[1]
    case direction
    when 'up'
      row -= 1
    when 'down'
      row += 1
    when 'left'
      col -= 1
    when 'right'
      col += 1
    else
      puts 'you shouldnt be here'
    end
    [row, col]
  end
end
