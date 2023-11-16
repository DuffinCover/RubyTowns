# frozen_string_literal: true

require 'colorize'
require 'colorized_string'
require 'rainbow'
require_relative 'building_shapes'

class BuildingCards
  @shapes = BuildingShapes.new
  def self.all_buildings
    {
      Bakery: BuildingCards.bakery,
      Cottage: BuildingCards.cottage,
      Chapel: BuildingCards.chapel,
    }
  end
  
  def self.abbey
    {
      type: 'church',
      name: 'Abbey',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[brick stone glass],
      shapes: @shapes.abbey,
      print: BuidlingColors.chapel('Aby')
    }
  end

  def self.bakery
    {
      type: 'church',
      name: 'Bakery',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[brick glass wheat],
      shapes: @shapes.bakery,
      print: BuidlingColors.chapel('Bkr')
    }
  end

  def self.chapel
    {
      type: 'church',
      name: 'Chapel',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[stone glass],
      shapes: @shapes.chapel,
      print: BuidlingColors.chapel('Chp')
    }
  end

  def self.cloister
    {
      print: BuidlingColors.chapel('Clo')
  }
  end

  def self.cottage
    {
      type: 'cottage',
      name: 'Cottage',
      abv: 'Ctg',
      total_pieces: 3,
      point_value: 3,
      resources_need: %w[brick glass wheat],
      shapes: @shapes.cottage,
      print: BuidlingColors.cottage('Ctg')
    }
  end
end

class BuidlingColors


  def self.chapel(abv)
     Rainbow(abv).black.bg(:orange)
  end

  def self.cottage(abv)
      Rainbow(abv).black.bg(:aquamarine)
  end

  def self.farm(abv)
    Rainbow(abv).black.bg(:red)
  end

  def self.well(abv)
    Rainbow(abv).black.bg(:lightgray)
  end

  def self.factory(abv)
    Rainbow(abv).white.bg(:black)
  end

  def self.theater(abv)
    Rainbow(abv).black.bg(:goldenrod)
  end

  def self.tavern(abv)
    Rainbow(abv).white.bg(:darkgreen)
  end
end