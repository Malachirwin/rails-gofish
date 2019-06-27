class GoFishGame
  attr_reader :deck, :players, :player_turn, :logs, :player_names, :player_num, :level
  def initialize player_num:, logs: [], player_turn_index: 0, player_names: [], level: 'easy', players: [], deck: CardDeck.new
    @level = level
    @deck = deck
    @player_names = player_names
    @player_num = player_num
    @player_turn = player_turn_index
    @deck.shuffle
    @logs = logs
    if players == []
      setup(player_names)
    else
      @players = players
      @deck = deck
    end
  end

  def add_log(log)
    @logs.push(log)
  end

  def setup(player_names)
    player_hands = @deck.deal(player_num)
    @players = player_names.map.with_index do |name, index|
      Player.new(name: name, cards: player_hands[index])
    end
    while @players.length < @player_num
      @players.push(Player.new(name: "Bot #{@players.length}", cards: player_hands[@players.length], bot: true))
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
    logs = game['logs'].map {|l| Log.from_json(l)}
    GoFishGame.new(player_num: game['player_num'], player_names: game['player_names'], logs: logs, player_turn_index: game['player_turn'], players: players, deck: deck, level: level)
  end

  def as_json
    {'player_num' => player_num, 'player_names' => player_names, 'logs'=> logs.map(&:as_json), 'player_turn' => player_turn, 'players' => players.map(&:as_json), 'deck' => deck.as_json, 'level' => @level}
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
      player_names: player_names,
      logs: logs.map(&:to_player_json),
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
    next_turn if players[player_turn].cards_left == 0 && winners == false
  end

  def refill_cards
    players.each do |player|
      if player.cards_left == 0
        deck.refill(player)
      end
    end
  end

  def next_player
    players[player_turn]
  end

  def run_turn(fisher:, target:, rank:)
    result = run_request(fisher: fisher, target: target, rank: rank)
    @logs.push(Log.new(fisher: fisher, target: target, rank: rank, result: result))
    fisher.pair_cards
    refill_cards
    next_turn if fisher.cards_left == 0
    run_bots_turns
    result
  end

  def pick_target_and_rank
    if level == 'easy'
      random_card_and_player
      pick_player_and_card(next_player)
    else
      pick_player_and_card(next_player)
    end
  end

  def random_card_and_player
    player_to_ask = players[rand(players.length - 1)]
    until (player_to_ask != next_player && player_to_ask.cards_left != 0)
      player_to_ask = players[rand(players.length)]
    end
    return [next_player.player_hand[rand(next_player.player_hand.length - 1)], player_to_ask]
  end

  def pick_player_and_card(player)
    cards = player.player_hand.select { |card| logs.map{ |log| log.rank == card.rank }.include?(true) }
    if cards.length != 0
      logs.select{|log| log.rank == cards.first.rank}.reverse[0..9].map do |log|
        if player.name != log.fisher.name && log.fisher.cards_left != 0
          return [cards.first, players_find_by(name: log.fisher.name)]
        end
      end
    end
    return random_card_and_player
  end

  def run_bots_turns
    if next_player.bot && !winners
      card, target = pick_target_and_rank
      run_turn(fisher: next_player, target: target, rank: card.rank)
    end
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
    return false if deck.has_cards?
    return players.clone.sort_by{|pl| pl.points}.reverse()
  end
end
