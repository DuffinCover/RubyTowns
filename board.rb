require "tty-prompt"
require_relative 'town_core'
require 'pry'

class GameMenu

  def initialize
    @town = TownCore.new
    default_menu
  end


  def prompt_instance
    TTY::Prompt.new
  end

def resource_menu
  @town.show_grid
  prompt = prompt_instance
  choices = @town.resources
  resource = prompt.select("Which Resource?", choices)
  location_menu(resource)
end

def location_menu(choice)
  @town.show_grid
  prompt = prompt_instance
  location = prompt.collect do
    key(:row).ask("Row? (1-4)")
    key(:col).ask("Column?(1-4)")
  end
  @town.place(choice, location)
  default_menu

end

def default_menu
  @town.show_grid
  prompt = prompt_instance
  prompt.select("Choose your action?") do |menu|
    menu.choice "Place", -> {resource_menu}
    menu.choice "Build", 2
    menu.choice "Score", 3
  end
end

# prompt = TTY::Prompt.new
# town.show_grid
# prompt.select("Choose your action?") do |menu|
#   menu.choice "Place", 
#   menu.choice "Build", 2
# end
end

GameMenu.new