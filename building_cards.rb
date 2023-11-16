# frozen_string_literal: true

require 'colorize'
require 'colorized_string'
require 'rainbow'
require_relative 'building_shapes'

class BuildingCards
  @shapes = BuildingShapes.new
  def self.all_buildings
    {
      Abbey: BuildingCards.abbey,
      Chapel: BuildingCards.chapel,
      Chloister: BuildingCards.cloister,
      Temple: BuildingCards.temple,
      Bank: BuildingCards.bank,
      Factory: BuildingCards.factory,
      Trading_Post: BuildingCards.trading_post,
      Warehouse: BuildingCards.warehouse,
      Farm: BuildingCards.farm,
      Granary: BuildingCards.granary,
      Greenhouse: BuildingCards.greenhouse,
      Orchard: BuildingCards.orchard,
      Almshouse: BuildingCards.almshouse,
      Feast_Hall: BuildingCards.feast_hall,
      Inn: BuildingCards.inn,
      Tavern: BuildingCards.tavern,
      Bakery: BuildingCards.bakery,
      Market: BuildingCards.market,
      Tailer: BuildingCards.tailor,
      Theater: BuildingCards.theater,
      Fountain: BuildingCards.fountain,
      Millstone: BuildingCards.millstone,
      Shed: BuildingCards.shed,
      Well: BuildingCards.well,
      Cottage: BuildingCards.cottage
    }
  end
  def self.all_buildings_by_cat
    {
      Church: {
        Abbey: BuildingCards.abbey,
        Chapel: BuildingCards.chapel,
        Chloister: BuildingCards.cloister,
        Temple: BuildingCards.temple

      },
      Factory: {
        Bank: BuildingCards.bank,
        Factory: BuildingCards.factory,
        Trading_Post: BuildingCards.trading_post,
        Warehouse: BuildingCards.warehouse
      },
      Farm: {
        Farm: BuildingCards.farm,
        Granary: BuildingCards.granary,
        Greenhouse: BuildingCards.greenhouse,
        Orchard: BuildingCards.orchard
      },
      Tavern: {
        Almshouse: BuildingCards.almshouse,
        Feast_Hall: BuildingCards.feast_hall,
        Inn: BuildingCards.inn,
        Tavern: BuildingCards.tavern
      },
      Theater: {
        Bakery: BuildingCards.bakery,
        Market: BuildingCards.market,
        Tailer: BuildingCards.tailor,
        Theater: BuildingCards.theater
      },
      Well: {
        Fountain: BuildingCards.fountain,
        Millstone: BuildingCards.millstone,
        Shed: BuildingCards.shed,
        Well: BuildingCards.well
      },

      Cottage: BuildingCards.cottage

    }
  end

  # -------------------------COTTAGE--------------------------

  def self.cottage
    {
      type: 'Cottage',
      name: 'Cottage',
      abv: 'Ctg',
      total_pieces: 3,
      point_value: 3,
      resources_need: %w[brick glass wheat],
      shapes: @shapes.cottage,
      print: BuildingColors.cottage('Ctg'),
      scoring: false # needs to be fed, might as well make it a bool
    }
  end

  # -------------------------CHURCH--------------------------

  def self.abbey
    {
      type: 'Church',
      name: 'Abbey',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[brick stone glass],
      shapes: @shapes.abbey,
      print: BuildingColors.chapel('Aby')
    }
  end

  def self.chapel
    {
      type: 'Church',
      name: 'Chapel',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[stone glass],
      shapes: @shapes.chapel,
      print: BuildingColors.chapel('Chp')
    }
  end

  def self.cloister
    {
      type: 'Church',
      name: 'Cloister',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[wood brick stone glass],
      shapes: @shapes.cloister,
      print: BuildingColors.chapel('Clo')
    }
  end

  def self.temple
    {
      type: 'Church',
      name: 'Temple',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[brick stone glass],
      shapes: @shapes.temple,
      print: BuildingColors.chapel('Tmp')
    }
  end

  # -------------------------TAVERN--------------------------

  def self.almshouse
    {
      type: 'Tavern',
      name: 'Almshouse',
      total_pieces: 3,
      point_value: 4,
      resources_need: %w[stone glass],
      shapes: @shapes.almshouse,
      print: BuildingColors.tavern('Alm')
    }
  end

  def self.feast_hall
    {
      type: 'Tavern',
      name: 'Feast Hall',
      total_pieces: 3,
      point_value: 4,
      resources_need: %w[wood glass],
      shapes: @shapes.feast_hall,
      print: BuildingColors.tavern('Fst')
    }
  end

  def self.inn
    {
      type: 'Tavern',
      name: 'Inn',
      total_pieces: 3,
      point_value: 4,
      resources_need: %w[wheat stone glass],
      shapes: @shapes.inn,
      print: BuildingColors.tavern('Inn')
    }
  end

  def self.tavern
    {
      type: 'Tavern',
      name: 'Tavern',
      total_pieces: 3,
      point_value: 4,
      resources_need: %w[brick glass],
      shapes: @shapes.tavern,
      print: BuildingColors.tavern('Tvn')
    }
  end

  # -------------------------THEATER--------------------------

  def self.bakery
    {
      type: 'Theater',
      name: 'Bakery',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[brick glass wheat],
      shapes: @shapes.bakery,
      print: BuildingColors.theater('Bkr')
    }
  end

  def self.market
    {
      type: 'Theater',
      name: 'Market',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[wood glass stone],
      shapes: @shapes.market,
      print: BuildingColors.theater('Mkt')
    }
  end

  def self.tailor
    {
      type: 'Theater',
      name: 'Tailor',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[wheat glass stone],
      shapes: @shapes.tailor,
      print: BuildingColors.theater('Tlr')
    }
  end

  def self.theater
    {
      type: 'Theater',
      name: 'Theater',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[stone glass wood],
      shapes: @shapes.theater,
      print: BuildingColors.theater('Thr')
    }
  end

  # -------------------------FARM-----------------------------

  def self.farm
    {
      type: 'Farm',
      name: 'Farm',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[wheat wood],
      shapes: @shapes.farm,
      print: BuildingColors.farm('Frm')
    }
  end

  def self.granary
    {
      type: 'Farm',
      name: 'Granary',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[wheat wood brick],
      shapes: @shapes.granary,
      print: BuildingColors.farm('Gny')
    }
  end

  def self.greenhouse
    {
      type: 'Farm',
      name: 'Greenhouse',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[wheat glass wood wood],
      shapes: @shapes.greenhouse,
      print: BuildingColors.farm('Grn')
    }
  end

  def self.orchard
    {
      type: 'Farm',
      name: 'Orchard',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[stone wheat wood],
      shapes: @shapes.orchard,
      print: BuildingColors.farm('Orc')
    }
  end

  # -------------------------FACTORY--------------------------

  def self.factory
    {
      type: 'Factory',
      name: 'Factory',
      total_pieces: 5,
      point_value: 0,
      resources_need: %w[wood brick stone],
      shapes: @shapes.factory,
      print: BuildingColors.factory('Fct')
    }
  end

  def self.warehouse
    {
      type: 'Factory',
      name: 'Warehouse',
      total_pieces: 5,
      point_value: 0,
      resources_need: %w[brick wheat wood],
      shapes: @shapes.warehouse,
      print: BuildingColors.factory('Wrh')
    }
  end

  def self.trading_post
    {
      type: 'Factory',
      name: 'Trading Post',
      total_pieces: 5,
      point_value: 0,
      resources_need: %w[wood stone brick],
      shapes: @shapes.trading_post,
      print: BuildingColors.factory('Trd')
    }
  end

  def self.bank
    {
      type: 'Factory',
      name: 'Bank',
      total_pieces: 5,
      point_value: 0,
      resources_need: %w[wheat wood glass brick],
      shapes: @shapes.bank,
      print: BuildingColors.factory('Bnk')
    }
  end



  # -------------------------WELL-----------------------------

  def self.well
    {
      type: 'Well',
      name: 'Well',
      total_pieces: 2,
      point_value: 2,
      resources_need: %w[wood stone],
      shapes: @shapes.well,
      print: BuildingColors.well('Wel')
    }
  end

  def self.shed
    {
      type: 'Well',
      name: 'Shed',
      total_pieces: 2,
      point_value: 2,
      resources_need: %w[wood stone],
      shapes: @shapes.well,
      print: BuildingColors.well('Shd')
    }
  end

  def self.millstone
    {
      type: 'Well',
      name: 'Millstone',
      total_pieces: 2,
      point_value: 2,
      resources_need: %w[wood stone],
      shapes: @shapes.well,
      print: BuildingColors.well('Mls')
    }
  end

  def self.fountain
    {
      type: 'Well',
      name: 'Fountain',
      total_pieces: 2,
      point_value: 2,
      resources_need: %w[wood stone],
      shapes: @shapes.well,
      print: BuildingColors.well('Ftn')
    }
  end
end

class BuildingColors
  def self.chapel(abv)
    Rainbow(abv).black.bg(:orange)
  end

  def self.cottage(abv)
    Rainbow(abv).black.bg(:darkcyan)
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
