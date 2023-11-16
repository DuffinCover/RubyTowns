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
    }
  end

  def self.wheat
    {
      name: 'wheat',
      print: Rainbow('Wh ').black.bg(:goldenrod),
    }
  end

  def self.brick
    {
      name: 'brick',
      print: Rainbow('Br ').black.bg(:orangered),
    }
  end

  def self.glass
    {
      name: 'glass',
      print: Rainbow('Gl ').black.bg(:darkturquoise),
    }
  end

  def self.stone
    {
      name: 'stone',
      print: Rainbow('St ').black.bg(:darkgray),
    }
  end

  def self.empty
    {
      name: 'empty',
      print: ColorizedString['   '].colorize('cyan'.to_sym),
    }
  end
end


