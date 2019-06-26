class GoFishGame
  attr_reader :deck, :players, :player_turn
  def initialize player_turn_index: 0, player_names: [], level: 'easy', players: [], deck: CardDeck.new
    @level = level
    @deck = deck
    @player_turn = player_turn_index
    @deck.shuffle
    if player_names != []
      setup(player_names)
    else
      @players = players
      @deck = deck
    end
  end

  def setup(player_names)
    player_hands = @deck.deal(player_names.length)
    @players = player_names.map.with_index do |name, index|
      Player.new(name: name, cards: player_hands[index])
    end
  end

  def self.load(hash)
    return nil if hash.blank?
    self.from_json(hash)
  end

  def self.from_json(hash)
    game = hash
    players = game['players'].map {|pl| Player.from_json(pl)}
    level = game['level']
    deck = CardDeck.from_json(game['deck'])
    GoFishGame.new(player_turn_index: game['player_turn'], players: players, deck: deck, level: level)
  end

  def as_json
    {'player_turn' => player_turn, 'players' => players.map(&:as_json), 'deck' => deck.as_json, 'level' => @level}
  end

  def players_find_by(name: '')
    if name != ''
      return players.detect {|pl| pl.name == name}
    end
    'No player found'
  end

  def opponents(player)
    players.select { |pl| pl.name != player.name }
  end

  def players_json(name)
    player = players_find_by(name: name)
    {
      player_turn: player_turn,
      player: player.as_json,
      opponents: opponents(player).map(&:as_opponent_json),
      cards_in_deck: deck.cards_left,
      is_turn: is_turn(player)
    }
  end

  def is_turn player
    players[player_turn] == player
  end

  def self.dump(obj)
    obj.as_json
  end

  def next_turn
    if player_turn == (players.length - 1)
      @player_turn = 0
    else
      @player_turn += 1
    end
  end

  def refill_cards
    players.each do |player|
      if player.cards_left == 0
        deck.refill(player)
      end
    end
  end

  def run_turn(fisher:, target:, rank:)
    result = run_request(fisher: fisher, target: target, rank: rank)
    players.map(&:pair_cards)
    refill_cards
    result
  end

  def run_request(fisher:, target:, rank:)
    if fisher.player_hand.select {|c| c.rank == rank}.length > 0
      cards = target.player_hand.select {|c| c.rank == rank}
      target.remove_cards_by_rank(rank)
      if cards.length > 0
        fisher.take cards
        cards.map(&:value).join(', ')
      else
        card = deck.take_card
        next_turn
        fisher.take(card) if card
        'Go Fish'
      end
    end
  end

  def winners
    players.each do |player|
      if player.cards_left != 0
        return false
      end
    end
    players.clone.sort_by{|pl| pl.points}
  end
end
