require 'rails_helper'
describe 'GoFishGame' do
  before do
    player_names = ['Malachi', 'Jimmy', 'Bob', 'Fred', 'Orange', 'Apple']
    @game = GoFishGame.new(level: 'easy', player_names: player_names)
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
  end
end
