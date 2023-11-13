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
      resources_need: %w[wheat brick glass],
      patterns: ['.[t].{2}[b][g]', '[b].(3)[g][t]', '[g][b].(2)[t].', '[t][g].(3)[b]']
    }
  end
end

# YBxx
# xRxx
# xxxx
# xxxx
