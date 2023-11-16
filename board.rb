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
    choices[:back] = 'go back'
    resource = prompt.select('Which Resource?', choices, cycle: true)
    location_menu(resource)
  end

  def location_menu(choice)
    @town.show_grid
    go_back(choice)
    location = collect_location
    @town.place(choice, @town.location_coords(location))
    default_menu
  end

  def collect_location
    prompt = prompt_instance
    location = prompt.collect do
      key(:row).ask('Row? (1-4)', convert: :int) do |q|
        q.messages[:convert?] = "Lets not be coy. %{value} isn't a number"
      end
      key(:col).ask('Column?(1-4)',convert: :int) do |q|
        q.messages[:convert?] = "Lets not be coy. %{value} isn't a number"
      end
    end
    location.each do |key, value|
      location[key] = keep_in_limits(value)
    end
    location
  end

  def default_menu
    @town.show_grid
    prompt = prompt_instance
    prompt.select('Choose your action?', cycle: true) do |menu|
      menu.choice 'debug', -> {show_me_stuff}
      menu.choice 'Place', -> { resource_menu }
      menu.choice 'Build', -> { build_menu }
      menu.choice 'Undo Last' , -> {undo}
      menu.choice 'Score', 3
      menu.choice 'Start over', -> { reset_grid }
      menu.choice 'Exit', -> {leave_game}
    end
  end

  def build_menu
    @town.show_grid
    choices = @town.build
    prompt = prompt_instance
    if choices == []
      prompt.select('nothing to build!') do |menu|
        menu.choice 'Return to main menu', -> { default_menu }
      end
    end
    choices << 'go back'
    selection = prompt.select('You can build:', choices, cycle: true)
    choosen_building_menu(selection)
  end

  def choosen_building_menu(selection)
    go_back(selection)
    choices = @town.highlight_choice(selection)
    @town.show_grid
    choices << 'go back'
    prompt = prompt_instance
    selection = prompt.select('which space?', choices, cycle: true)
    follow_build_choice(selection)
  end

  def follow_build_choice(selection)
    if selection == 'go back'
      @town.changed_mind
      build_menu
    else
      @town.place_building(selection)
      default_menu
    end
  end

  def undo
    prompt = prompt_instance
    prompt.select('What do you want to undo?') do |menu|
      menu.choice 'Undo build', -> {undo_build}
      menu.choice 'Undo place', -> {undo_place}
      menu.choice 'Go back', -> {default_menu}
    end
  end

  def undo_build
    @town.changed_mind
    default_menu
  end

  def undo_place
    location = collect_location
    @town.remove_from_board(@town.location_coords(location))
    default_menu
  end

  def reset_grid
    @town.reset_grid
    default_menu
  end

  def go_back(choice)
    if choice == 'go back'
      default_menu
    end
  end

  def keep_in_limits(value)
    if value < 1
      value = 1
    end
    if value > 4
      value = 4
    end
    value
  end

  def leave_game
    puts 'Thanks for playing!'
    exit(0)
  end

  def show_me_stuff
    puts 'Removed for building'
    puts @town.remove_for_building

    puts

    puts 'Built'
    puts @town.currently_building
    prompt = prompt_instance
    prompt.select('return to menu?') do |menu|
      menu.choice 'return', -> {default_menu}
    end
  end
end

GameMenu.new
