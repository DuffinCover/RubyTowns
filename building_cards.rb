# frozen_string_literal: true

class BuildingCards
  def self.cottage
    {
      name: 'Cottage',
      point_value: 3,
      pattern: [%w[x Y x]
                %w[R U x]
                %w[x x x]],
        score_condition: "fed"
        fed: false
    }
  end
end
