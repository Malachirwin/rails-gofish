class Player
  attr_reader :name, :matches
  def initialize name:, cards: [], matches: []
    @name = name
    @cards = cards
    @matches = matches
  end

  def player_hand
    @cards
  end

  def take cards
    @cards.push(*cards)
  end

  def pair_cards
    player_hand.each do |originalCard|
      sameRank = player_hand.select { |card| card.rank == originalCard.rank }
      if sameRank.length == 4
        @matches.push(sameRank)
        @cards = player_hand.select { |card| !sameRank.include? card }
      end
    end
  end

  def remove_cards_by_rank rank
    @cards = player_hand.select { |card| !(card.rank == rank) }
  end

  def points
    @matches.length
  end

  def cards_left
    player_hand.length
  end

  def set_hand cards
    @cards = cards
  end

  def as_opponent_json
    matches_json = matches.map { |match| match.map(&:as_json) }
    {'name' => name, 'cards_in_hand' => cards_left, 'matches' => matches_json}
  end

  def as_json(options={})
    card_json = player_hand.map(&:as_json)
    matches_json = matches.map { |match| match.map(&:as_json) }
    {'name' => name, 'cards' => card_json, 'matches' => matches_json}
  end

  def self.from_json(obj)
    cards = obj['cards'].map do |c|
      Card.from_json(c)
    end
    matches = obj['matches'].map do |c|
      Card.from_json(c)
    end
    Player.new(name: obj['name'], cards: cards, matches: matches)
  end
end
