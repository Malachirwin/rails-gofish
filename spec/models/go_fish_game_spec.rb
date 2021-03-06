require 'rails_helper'
describe 'GoFishGame' do
  before do
    player_names = ['Malachi', 'Jimmy', 'Bob', 'Fred', 'Orange', 'Apple']
    @game = GoFishGame.new(level: 'easy', player_names: player_names, player_num: player_names.length)
  end

  it 'Starts a game with x number of players' do
    expect(@game.players.length).to eq 6
  end

  it 'returns deck' do
    expect(@game.deck).to_not eq nil
  end

  it "returns json hash" do
    expect(@game.as_json).to include_json players: [{name: 'Malachi', cards: [], matches: []}]
    expect(@game.as_json).to include_json deck: {cards: []}
    expect(@game.as_json).to include_json level: 'easy'
  end

  it "returns parsed game" do
    game = @game.as_json
    game = GoFishGame.from_json(game)
    expect(game.class).to eq GoFishGame
    expect(game.players.length).to eq 6
  end

  it 'returns player json' do
    expect(@game.players_json('Malachi')).to include_json( player: {name: 'Malachi', cards: [], matches: []} )
    expect(@game.players_json('Malachi')).to include_json( opponents: [{name: 'Jimmy', 'cards_in_hand' => [], matches: []}] )
    expect(@game.players_json('Malachi')).to include_json( cards_in_deck: 22 )
  end

  it 'updates the log when a turn is run' do
    player1, player2 = @game.players
    player1.set_hand([Card.new(rank: '10', suit: 'H'), Card.new(rank: 'A', suit: 'D')])
    player2.set_hand([Card.new(rank: '10', suit: 'D'), Card.new(rank: '10', suit: 'C'), Card.new(rank: '3', suit: 'C')])
    result = @game.run_turn(fisher: player1, target: player2, rank: '10')
    expect(@game.logs.first.fisher).to eq player1
    expect(@game.logs.first.target).to eq player2
    expect(@game.logs.first.result).to eq result
    expect(@game.logs.first.rank).to eq '10'
  end

  describe 'Runs Request and Turn' do
    it 'runs a request' do
      player1, player2 = @game.players
      player1.set_hand([Card.new(rank: '10', suit: 'H'), Card.new(rank: 'A', suit: 'D')])
      player2.set_hand([Card.new(rank: '10', suit: 'D'), Card.new(rank: '3', suit: 'C')])
      result = @game.run_request(fisher: player1, target: player2, rank: '10')
      expect(result).to eq '10 of Diamonds'
      expect(player1.cards_left).to eq 3
      expect(player2.cards_left).to eq 1
    end

    it 'runs a request and goes fishing' do
      player1, player2 = @game.players
      player1.set_hand([Card.new(rank: '10', suit: 'H'), Card.new(rank: 'A', suit: 'D')])
      player2.set_hand([Card.new(rank: 'J', suit: 'D'), Card.new(rank: '3', suit: 'C')])
      result = @game.run_request(fisher: player1, target: player2, rank: '10')
      expect(result).to eq 'Go Fish'
      expect(player1.cards_left).to eq 3
      expect(player2.cards_left).to eq 2
    end

    it 'runs a request and takes more than one card' do
      player1, player2 = @game.players
      player1.set_hand([Card.new(rank: '10', suit: 'H'), Card.new(rank: 'A', suit: 'D')])
      player2.set_hand([Card.new(rank: '10', suit: 'D'), Card.new(rank: '10', suit: 'C'), Card.new(rank: '3', suit: 'C')])
      result = @game.run_request(fisher: player1, target: player2, rank: '10')
      expect(result).to eq '10 of Diamonds, 10 of Clubs'
      expect(player1.cards_left).to eq 4
      expect(player2.cards_left).to eq 1
    end

    it 'incriments the player_turn' do
      expect(@game.player_turn).to eq 0
      player1, player2 = @game.players
      player1.set_hand([Card.new(rank: '10', suit: 'H'), Card.new(rank: 'A', suit: 'D')])
      player2.set_hand([Card.new(rank: '4', suit: 'D'), Card.new(rank: 'K', suit: 'C'), Card.new(rank: '3', suit: 'C')])
      result = @game.run_request(fisher: player1, target: player2, rank: '10')
      expect(@game.player_turn).to eq 1
    end

    it 'runs a turn' do
      player1, player2 = @game.players
      player1.set_hand([Card.new(rank: '10', suit: 'H'), Card.new(rank: 'A', suit: 'D')])
      player2.set_hand([Card.new(rank: '10', suit: 'D'), Card.new(rank: '10', suit: 'C'), Card.new(rank: '3', suit: 'C')])
      result = @game.run_turn(fisher: player1, target: player2, rank: '10')
      expect(result).to eq '10 of Diamonds, 10 of Clubs'
      expect(player1.cards_left).to eq 4
      expect(player2.cards_left).to eq 1
    end

    it 'runs a turn and refill cards' do
      player1, player2 = @game.players
      player1.set_hand([Card.new(rank: '10', suit: 'H'), Card.new(rank: 'A', suit: 'D')])
      player2.set_hand([Card.new(rank: '10', suit: 'D'), Card.new(rank: '10', suit: 'C')])
      result = @game.run_turn(fisher: player1, target: player2, rank: '10')
      expect(player1.cards_left).to eq 4
      expect(player2.cards_left).to eq 5
    end

    it 'returns false when there is no winners' do
      expect(@game.winners).to eq false
    end

    it 'returns all the rankings' do
      def match(rank)
        [Card.new(rank: rank, suit: 'D'), Card.new(rank: rank, suit: 'H'), Card.new(rank: rank, suit: 'C'), Card.new(rank: rank, suit: 'S')]
      end
      player1, player2, player3, player4, player5, player6 = @game.players
      player1.set_hand(match('10'))
      player2.set_hand([*match('A'), *match('5')])
      player3.set_hand([*match('A'), *match('5'), *match('7')])
      player4.set_hand([*match('J'), *match('K'), *match('Q'), *match('2')])
      player5.set_hand([*match('3')])
      player6.set_hand([*match('8'), *match('6')])
      @game.players.map(&:pair_cards)
      @game.deck.remove_all_cards_from_deck
      expect(@game.winners).to eq [player4, player3, player6, player2, player5, player1]
    end
  end

  it "runs a turn and skips players who don't have cards" do
    expect(@game.player_turn).to eq 0
    player1, player2, player3, player4 = @game.players
    player1.set_hand([Card.new(rank: '10', suit: 'H'), Card.new(rank: 'A', suit: 'D')])
    player4.set_hand([Card.new(rank: '4', suit: 'D'), Card.new(rank: 'K', suit: 'C'), Card.new(rank: '3', suit: 'C')])
    player2.set_hand([])
    player3.set_hand([])
    @game.deck.remove_all_cards_from_deck
    result = @game.run_request(fisher: player1, target: player4, rank: '10')
    expect(@game.player_turn).to eq 3
  end

  describe "Runs bot turns" do
    it 'fills the game with bots' do
      player_names = ['Malachi', 'Jimmy']
      game = GoFishGame.new(level: 'easy', player_names: player_names, player_num: 4)
      expect(game.players.length).to eq 4
    end

    it 'picks something based on the log' do
      player_names = ['Malachi', 'Jimmy']
      game = GoFishGame.new(level: 'hard', player_names: player_names, player_num: 4)
      player1, player2, player3 = game.players
      game.add_log(Log.new(fisher: player2, target: player3, rank: '10', result: '10 of Spades'))
      expect(game.pick_player_and_card(player1).include?(player2))
    end

    it "picks the last thing that wasn't them based on the log" do
      player_names = ['Malachi', 'Jimmy']
      game = GoFishGame.new(level: 'hard', player_names: player_names, player_num: 4)
      player1, player2, player3 = game.players
      player1.set_hand([Card.new(rank: '10', suit: 'H')])
      game.add_log(Log.new(fisher: player2, target: player3, rank: '10', result: '10 of Spades'))
      game.add_log(Log.new(fisher: player1, target: player3, rank: '8', result: '8 of Spades'))
      expect(game.pick_player_and_card(player1).include?(player2))
    end

    it "runs bot turns after human" do
      player_names = ['Malachi', 'Jimmy']
      game = GoFishGame.new(level: 'hard', player_names: player_names, player_num: 4)
      game.next_turn
      player1, player2, player3, player4 = game.players
      player2.set_hand([Card.new(rank: '10', suit: 'H'), Card.new(rank: 'A', suit: 'D')])
      player4.set_hand([Card.new(rank: '4', suit: 'D'), Card.new(rank: 'K', suit: 'C'), Card.new(rank: '3', suit: 'C')])
      result = game.run_turn(fisher: player2, target: player4, rank: '10')
      game.add_log(Log.new(fisher: player2, target: player3, rank: '10', result: '10 of Spades'))
      game.add_log(Log.new(fisher: player1, target: player3, rank: '8', result: '8 of Spades'))
      expect(game.logs.length).to be >= 5
    end
  end
end
