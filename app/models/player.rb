class Player
  def initialize name, cards=[], matches=[]
    @name = name
    @cards = cards
    @matches = matches
  end

  def name
    @name
  end

  def player_hand
    @cards
  end

  def take cards
    @cards.push(*cards)
  end

  def matches
    @matches
  end

  def pair_cards
    @cards.each do |originalCard|
      sameRank = @cards.select { |card| card.rank == originalCard.rank }
      if sameRank.length == 4
        @matches.push(sameRank)
        @cards = @cards.select { |card| !sameRank.include? card }
      end
    end
  end

  def remove_cards_by_rank rank
    @cards = @cards.select { |card| !(card.rank == rank) }
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
    matches_json = matches.map { |match| match.map { |c| c.as_json } }
    {'name' => name, 'cards_in_hand' => cards_left, 'matches' => matches_json}
  end

  def as_json(options={})
    card_json = player_hand.map { |c| c.as_json }
    matches_json = matches.map { |match| match.map { |c| c.as_json } }
    {'name' => name, 'cards' => card_json, 'matches' => matches_json}
  end

  def self.from_json(obj)
    cards = obj['cards'].map do |c|
      Card.from_json(c)
    end
    matches = obj['matches'].map do |c|
      Card.from_json(c)
    end
    Player.new(obj['name'], cards, matches)
  end
end
