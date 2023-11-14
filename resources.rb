require 'colorize'
require 'colorized_string'
require 'rainbow'

class Resources
  def self.all_resources
    {
      wood: Resources.wood,
      wheat: Resources.wheat,
      brick: Resources.brick,
      stone: Resources.stone,
      glass: Resources.glass
    }
  end

  def self.wood
    {
      name: 'wood',
      print: Rainbow('Wo ').black.bg(:saddlebrown),
      piece: 'w'
    }
  end

  def self.wheat
    {
      name: 'wheat',
      print: Rainbow('Wh ').black.bg(:goldenrod),
      piece: 't'
    }
  end

  def self.brick
    {
      name: 'brick',
      print: Rainbow('Br ').black.bg(:orangered),
      piece: 'b'
    }
  end

  def self.glass
    {
      name: 'glass',
      print: Rainbow('Gl ').black.bg(:darkturquoise),
      piece: 'g'
    }
  end

  def self.stone
    {
      name: 'stone',
      print: Rainbow('St ').black.bg(:darkgray),
      piece: 's'
    }
  end

  def self.empty
    {
      name: 'empty',
      print: ColorizedString['   '].colorize('cyan'.to_sym),
      piece: 'x'
    }
  end
end

class BuidlingColors

    def self.all_buildings
        {
            Cottage: BuidlingColors.cottage
        }
    end

    def self.cottage
        {
            name: 'Cottage',
            print: Rainbow('Ctg').black.bg(:aquamarine),
            piecs: 'Ctg',
        }
    end
end
