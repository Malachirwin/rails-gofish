class GoFishGame
  def initialize player_names:, level:
    @level = level
    @deck = CardDeck.new
    player_hands = @deck.deal
    @players = player_names.map.with_index do |name, index|
      Player.new(name, player_hands[index])
    end
  end

  def players
    @players
  end

  def deck
    @deck
  end

  def state
    {players: players_state, deck: deck.state, level: @level}
  end

  def players_state
    players.map { |pl| [pl.name, pl.player_hand.map {|c| c.value}] }
  end
end
