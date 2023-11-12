require 'tty-prompt'
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
    resource = prompt.select('Which Resource?', choices)
    location_menu(resource)
  end

  def location_menu(choice)
    @town.show_grid
    prompt = prompt_instance
    location = prompt.collect do
      key(:row).ask('Row? (1-4)')
      key(:col).ask('Column?(1-4)')
    end
    @town.place(choice, @town.location_coords(location))
    default_menu
  end

  def default_menu
    @town.show_grid
    prompt = prompt_instance
    prompt.select('Choose your action?') do |menu|
      menu.choice 'Place', -> { resource_menu }
      menu.choice 'Build', -> { build_menu }
      menu.choice 'Score', 3
      menu.choice 'Start over', -> { reset_grid }
    end
  end

  def build_menu
    @town.show_grid
    @town.build
  end

  def reset_grid
    @town.reset_grid
    default_menu
  end
end

GameMenu.new
