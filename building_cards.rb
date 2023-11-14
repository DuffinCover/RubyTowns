# frozen_string_literal: true
require 'regex'
require_relative 'building_shapes'

class BuildingCards
    @shapes = BuildingShapes.new
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
      abv: 'Ctg',
      total_pieces: 3,
      point_value: 3,
      resources_need: %w[brick glass wheat],
    #   patterns: [%r{.[t].{2}[b][g]}, %r{[b].{3}[g][t]}, %r{[g][b].{2}[t].}, %r{[t][g].{3}[b]}],
      shapes: {
        up: @shapes.normal_cottage
      }
    }
  end

end


# YBxx
# xRxx
# xxxx
# xxxx
