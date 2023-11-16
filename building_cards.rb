# frozen_string_literal: true

require 'colorize'
require 'colorized_string'
require 'rainbow'
require_relative 'building_shapes'

class BuildingCards
  @shapes = BuildingShapes.new
  def self.all_buildings
    {
      Church: {
        Abbey: BuildingCards.abbey,
        Chapel: BuildingCards.chapel,
        Chloister: BuildingCards.chloister,
        Temple: BuildingCards.temple

      },
      Factory: {
        Bank: BuildingCards.bank,
        Factory: BuidlingCards.factory, 
        Trading_Post: BuidlingCards.trading_post, 
        Warehouse: BuildingCards.warehouse
      },
      Farm: {
        Farm: BuidlingCards.farm, 
        Granary: BuidlingCards.granary, 
        Greenhouse: BuidlingCards.greenhouse, 
        Orchard: BuidlingCards.orchard
      },
      Tavern: {
        Almshouse: BuildingCards.almshouse,
        Feast_Hall: BuidlingCards.feast_hall, 
        Inn: BuidlingCards.inn, 
        Tavern: BuidlingCards.tavern
      }, 
      Theater: {
        Bakery: BuildingCards.bakery,
        Market: BuildingCards.market, 
        Tailer: BuidlingCards.tailor, 
        Theater: BuidlingCards.theater
      }, 
      Well: {
        Fountain: BuidlingCards.fountain, 
        Millstone: BuidlingCards.millstone, 
        Shed: BuidlingCards.shed, 
        Well: BuidlingCards.well
      },
  
      Cottage: BuildingCards.cottage,
      
    }
  end

  # -------------------------COTTAGE--------------------------

  def self.cottage
    {
      type: 'cottage',
      name: 'Cottage',
      abv: 'Ctg',
      total_pieces: 3,
      point_value: 3,
      resources_need: %w[brick glass wheat],
      shapes: @shapes.cottage,
      print: BuildingColors.cottage('Ctg')
    }
  end

  # -------------------------CHURCH--------------------------

  def self.abbey
    {
      type: 'church',
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
      type: 'church',
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
      type: 'church',
      name: 'Cloister',
      total_pieces: 4,
      point_value: 4,
      resources_need: %w[wood brick stone glass],
      shapes: @shapes.chapel,
      print: BuildingColors.chapel('Clo')
    }
  end

  # -------------------------TAVERN--------------------------

  def self.almshouse
    {
      type: 'tavern',
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
      type: 'tavern',
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
      type: 'tavern',
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
      type: 'tavern',
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
      type: 'theater',
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
      type: 'theater',
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
      type: 'theater',
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
      type: 'theater',
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
      type: 'farm',
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
      type: 'farm',
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
      type: 'farm',
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
      type: 'farm',
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
    type: 'factory',
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
      type: 'factory',
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
      type: 'factory',
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
      type: 'factory',
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
      type: 'well',
      name: 'Well',
      total_pieces: 2, 
      point_value: 2, 
      resources_need: %w[wood stone],
      shapes: @shapes.well,
      print: BuildingColors.well('Wel'),
    }
  end

  def self.shed
    {
      type: 'well',
      name: 'Shed',
      total_pieces: 2, 
      point_value: 2, 
      resources_need: %w[wood stone],
      shapes: @shapes.well,
      print: BuildingColors.well('Shd'),
    }
  end

  def self.millstone
    {
      type: 'well',
      name: 'Millstone',
      total_pieces: 2, 
      point_value: 2, 
      resources_need: %w[wood stone],
      shapes: @shapes.well,
      print: BuildingColors.well('Mls'),
    }
  end

  def self.fountain
    {
      type: 'well',
      name: 'Fountain',
      total_pieces: 2, 
      point_value: 2, 
      resources_need: %w[wood stone],
      shapes: @shapes.well,
      print: BuildingColors.well('Ftn'),
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