class Player
  def initialize name, cards=[]
    @name = name
    @cards = cards
    @matches = []
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
end
