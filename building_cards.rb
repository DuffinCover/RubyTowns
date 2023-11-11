# frozen_string_literal: true

class BuildingCards
  def self.cottage
    {
      name: 'Cottage',
      point_value: 3,
      resources_need: %w[R U Y],
    #   pattern: [ %w[x Y x]
    #             ,%w[R U x]
    #             ,%w[x x x] ],
      score_condition: "fed",
      fed: false
    }
  end
end
# "xYxRUxxxx" "YxRU"


# "xxxxURxYx" 

# "xxxYUxxRx"

# "xxYxRUxxx"

# "RxxUYxxxx"