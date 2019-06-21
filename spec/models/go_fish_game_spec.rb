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
end
