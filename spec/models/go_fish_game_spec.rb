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
  # 
  # it 'request card' do
  #
  # end
end
