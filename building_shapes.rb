# frozen_string_literal: true

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

  #-------------------Church-------------------

  def abbey
    assemble_church([brick, stone, stone, glass])
  end

  def chapel
    assemble_church([stone, glass, stone, glass])
  end

  def cloister
    assemble_church([wood, brick, stone, glass])
  end

  def temple
    assemble_church([brick, brick, stone, glass])
  end

  def assemble_church(mats)
    mats[0].add_right(mats[1])
    mats[1].add_right(mats[2])
    mats[2].add_up(mats[3])
    mats[0]
  end

  #-------------------Cottage--------------------

  def cottage
    assemble_cottage([brick, glass, wheat])
  end

  def assemble_cottage(mats)
    mats[0].add_right(mats[1])
    mats[1].add_up(mats[2])
    mats[0]
  end

  #--------------------Farm---------------------

  def farm
    assemble_farm([wheat, wheat, wood, wood])
  end

  def orchard
    assemble_farm([stone, wheat, wood, wheat])
  end

  def greenhouse
    assemble_farm([wheat, glass, wood, wood])
  end

  def granary
    assemble_farm([wheat, wheat, brick, wood])
  end

  def assemble_farm(mats)
    mats[0].add_right(mats[1])
    mats[1].add_down(mats[2])
    mats[2].add_left(mats[3])
    mats[0]
  end


  #--------------------Theater------------------

  def bakery
    assemble_theater([wheat, glass, brick, brick])
  end

  def market
    assemble_theater([wood, glass, stone, stone])
  end

  def tailor
    assemble_theater([wheat, glass, stone, stone])
  end

  def theater
    assemble_theater([stone, glass, wood, wood])
  end

  def assemble_theater(mats)
    mats[0].add_down(mats[1])
    mats[1].add_right(mats[2])
    mats[1].add_left(mats[3])
    mats[0]
  end

  #--------------------Tavern-------------------

  def tavern
    assemble_tavern([brick, brick, glass])
  end

  def inn
    assemble_tavern([wheat, stone, glass])
  end

  def feast_hall
    assemble_tavern([wood, wood, glass])
  end

  def almshouse
    assemble_tavern([stone, stone, glass])
  end

  def assemble_tavern(mats)
    mats[0].add_right(mats[1])
    mats[1].add_right(mats[2])
    mats[0]
  end

  #--------------------Well---------------------
  def well
    assemble_well([wood, stone])
  end

  def assemble_well(mats)
    mats[0].add_right(mats[1])
    mats[0]
  end

  #--------------------Factory------------------
  def factory
    wd = wood
    br1 = brick
    st1 = stone
    st2 = stone
    br2 = brick

    wd.add_down(br1)
    br1.add_right(st1)
    st1.add_right(st2)
    st2.add_right(br2)
    wd
  end

  def bank
    assemble_utah_shape([brick, glass, wood, wheat, wheat])
  end

  def trading_post
    assemble_utah_shape([brick, wood, stone, stone, wood])
  end

  def assemble_utah_shape(mats)
    mats[0].add_left(mats[1])
    mats[1].add_left(mats[2])
    mats[2].add_up(mats[3])
    mats[3].add_right(mats[4])
    mats[0]
  end

  def warehouse
    assemble_u_shape([brick, wheat, wood, wheat, brick])
  end

  def assemble_u_shape(mats)
    mats[0].add_up(mats[1])
    mats[1].add_right(mats[2])
    mats[2].add_right(mats[3])
    mats[3].add_down(mats[4])
    mats[0]
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

  def rotate_n_times(n)
    temp_shape = clone
    n.times do
      temp_shape = rotate
    end
    temp_shape
  end

  def rotate
    temp_shape = clone
    recursive_rotate(temp_shape)
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
