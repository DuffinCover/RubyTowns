# frozen_string_literal: true

require 'tty-prompt'
require_relative 'town_core'
require 'pry'

class GameMenu
  def initialize
    @town = TownCore.new
    @demo_town = TownCore.new
    welcome_menu
    # default_menu
  end

  def prompt_instance
    TTY::Prompt.new
  end

  def title
    system('clear')
    system('cls')   
  puts '     _____     _          _____                   
    | __  |_ _| |_ _ _   |_   _|___ _ _ _ ___ ___ 
    |    -| | | . | | |    | | | . | | | |   |_ -|
    |__|__|___|___|_  |    |_| |___|_____|_|_|___|
                  |___|                           
     '
     puts
  end

  def welcome_menu                         
  title
  prompt = prompt_instance
  prompt.select('Welcome to Ruby Towns!', cycle: true) do |menu|
      menu.choice 'New Game', -> {game_setup}
      menu.choice 'Building Details', ->{card_details('welcome_menu')}
      menu.choice 'Tutorial', ->{tutorial_menu}
      menu.choice 'Exit', -> { leave_game }
  end

  end

  def game_setup
    alpha_message
    prompt = prompt_instance
    prompt.select('Do you want to learn how the game works?', cycle: true) do |menu|
      menu.choice 'How do I play this game?', -> {tutorial_menu}
      menu.choice 'Take me to the game already!', -> {default_menu}
    end

    binding.pry

  end

  def alpha_message
    puts 'This is a simplified implementation of the Tiny Towns board game.'
    puts 'The game is still a work in progress. We appreciate your patience as we continue to make it better.'
    puts 'Please feel free to send me any feedback you have!'

    puts 'The cards for this game are as follows: '
    puts 'Cottage, Farm, Chapel, Tavern, Theater, well'
    puts 
    puts 'Dont worry. You will be able to see what these do as you play. '
    puts 'Thank you for trying the alpha!'

  end

  def card_details(previous_menu)
    title
    buildings = @town.buildings_list
    choices = []
    buildings.each do |building|
      choices << building[:name]
    end
    choices << 'Go Back'
    prompt = prompt_instance
    selection = prompt.select('Choose a Building to Learn more about: ', choices, cycle: true)
    if selection == 'Go Back'
      self.public_send(previous_menu.downcase.to_sym)
    end
    specific_building_detail(selection, previous_menu)
  end

  def specific_building_detail(building_name, previous_menu)
    chosen_building = BuildingCards.public_send(building_name.downcase.to_sym)
    puts "Name: #{chosen_building[:name]}"
    puts "Building Type: #{chosen_building[:type]}"
    puts "Resources needed: #{chosen_building[:resources_need]}"
    puts "Rules: #{chosen_building[:rules]}"
    prompt = prompt_instance
    prompt.select('Display Building Shape?') do |menu|
      menu.choice 'Display', -> {show_building_shape(chosen_building, previous_menu)}
      menu.choice 'Go back to previous menu', -> {card_details(previous_menu)}
    end
  end

  def show_building_shape(chosen_building, previous_menu)
    @demo_town.reset_grid
    @demo_town.town_grid.place_building_shape(chosen_building[:shapes], [2,1])
    @demo_town.show_grid
    prompt = prompt_instance
    prompt.select('Go back to previous menu') do |menu|
      menu.choice 'Go back', -> {card_details(previous_menu)}
    end
  end

  # For when I want to figure out displaying rotational options
  # def display_building(chosen_building, rotation, previous_menu)
  #   @town.reset_grid
  #   @town.town_grid.place_building_shape(chosen_building[:shapes], [2,1])
  #   @town.show_grid

  # end

  def tutorial_menu
    system('clear')
    system('cls')                            
    title
    prompt = prompt_instance
    prompt.select('What would you like to know about?', cycle: true) do |menu|
      menu.choice 'What is my goal?', -> {goal_of_the_game}
      menu.choice 'What does a turn look like?', -> {placement_instructions}
      menu.choice 'How do I build a building?', -> {build_instructions}
      menu.choice 'Go back', -> {welcome_menu}
    end

  end

  def goal_of_the_game
    puts 'The goal of the game is to get the most points. In order to accomplish that, you need to build buildings.'
    puts 'Buildings are build by matching their pattern on the board with resources you get each turn.'
    puts 'You get points by fulfilling the scoring conditions of your buildings and by not having empty spaces on your board.'
    puts 'Empty spaces are worth -1 point each at the end of the game.'
    return_to_tutorial
  end

  def placement_instructions
    puts '1. You will be given a resource to place on your grid.'
    puts "2. To place, select 'Place' from the menu. Then select the resource you were given."
    puts '3. You will be asked for row and column where you would like to place that resource.'
    puts '4. If the space is empty, you can put that resource there. That is the only constraint - the space must be empty.'
    return_to_tutorial
  end


  def build_instructions
    puts '1. If you have resources on the board that match any rotation of a building pattern, you can build. Rotations are cool, reflections are not.'
    puts "2. You can build by selecting 'Build' from the menu. The game will tell you what buildings if any, you can build, and where they can be built."
    puts "3. You can undo your most recent build action. To do so, select 'Undo Last' from the menu and select 'Build.' It will replace the last building built with its resources."
    puts "WARNING: If you choose to build again, your previous build action is locked in and cannot be undone."
    return_to_tutorial
  end

  def return_to_tutorial
    prompt = prompt_instance
    prompt.select('Return to Tutorial Menu') do |menu|
      menu.choice 'Go Back', -> {tutorial_menu}
    end
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
        q.messages[:convert?] = "Lets not be coy. %<value>s isn't a number"
      end
      key(:col).ask('Column?(1-4)', convert: :int) do |q|
        q.messages[:convert?] = "Lets not be coy. %<value>s isn't a number"
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
      # menu.choice 'debug', -> { show_me_stuff }
      menu.choice 'Place', -> { resource_menu }
      menu.choice 'Build', -> { build_menu }
      menu.choice 'Undo Last', -> { undo }
      menu.choice 'Building Details', -> {card_details('default_menu')}
      menu.choice 'Score', -> { score }
      menu.choice 'Start over', -> { reset_grid }
      menu.choice 'Exit', -> { leave_game }
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
      menu.choice 'Undo build', -> { undo_build }
      menu.choice 'Undo place', -> { undo_place }
      menu.choice 'Go back', -> { default_menu }
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

  def score
    score = @town.score
    prompt =prompt_instance
    prompt.select("Your current score is #{score}. Do you want to continue? ") do |menu|
      menu.choice 'Keep going', -> {default_menu}
      menu.choice 'End Game', -> {welcome_menu}
    end
  end

  def reset_grid
    @town.reset_grid
    default_menu
  end

  def go_back(choice)
    return unless choice == 'go back'

    default_menu
  end

  def keep_in_limits(value)
    value = 1 if value < 1
    value = 4 if value > 4
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

    puts 'Building'
    puts @town.currently_building

    puts

    puts 'Grid'
    puts @town.town_grid.grid

    prompt = prompt_instance
    prompt.select('return to menu?') do |menu|
      menu.choice 'return', -> { default_menu }
    end
  end
end

GameMenu.new
