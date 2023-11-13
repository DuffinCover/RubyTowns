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
    #   shape: Shape.new('wheat').add_down(Shape.new('glass').add_left(Shape.new('brick')))
    }
  end
end


class Shape
    def initialize(material)
        @name = material
        @neighbors = 
        {
            up: nil,
            down: nil,
            left: nil,
            right: nil
        }
     
    end
attr_accessor :name, :neighbors
    def add_up(shape)
        @neighbors[:up] = shape if @neighbors[:up].nil?
        shape.neighbors[:down] = self if shape.neighbors[:down].nil?
    end

    def add_down(shape)
        @neighbors[:down] = shape if @neighbors[:down].nil?
        shape.neighbors[:up] = self if shape.neighbors[:up].nil?
    end

    def add_left(shape)
        @neighbors[:left] = shape if @neighbors[:left].nil?
        shape.neighbors[:right] = self if shape.neighbors[:right].nil?
    end

    def  add_right(shape)
        @neighbors[:right] = shape if@neighbors[:right].nil?
        shape.neighbors[:left] = self if shape.neighbors[:left].nil?
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
