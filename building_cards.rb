# frozen_string_literal: true
require 'regex'
require_relative 'building_shapes'

class BuildingCards
    @shapes = BuildingShapes.new
  def self.cottage
    {
      name: 'Cottage',
      abv: 'Ctg',
      total_pieces: 3,
      point_value: 3,
      resources_need: %w[brick glass wheat],
      shapes: {
        up: @shapes.normal_cottage,
        right: @shapes.cottage_right,
      }
    }
  end

  def self.chapel
    {
      name: 'Chapel',
      abv: 'Chp',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[brick glass wheat],
      shapes: {
        up: @shapes.chapel
      }
    }
    end

end


# YBxx
# xRxx
# xxxx
# xxxx
