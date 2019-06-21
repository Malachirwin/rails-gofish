require 'rails_helper'
describe Player do
  it 'has a name' do
    player = Player.new('Malachi')
    expect(player.name).to eq "Malachi"
  end
  it 'can be created with a list of cards' do
    cards = [Card.new("1", "S")]
    player = Player.new('Malachi', cards)
    expect(player.cards_left).to be 1
  end

  it 'takes cards and puts them at the bottom of its hand' do
    player = Player.new('Malachi')
    cards = [Card.new("1", "S"), Card.new("2", "D")]
    player.take(cards)
    expect(player.cards_left).to eq 2
  end

  it 'matches cards' do
    player = Player.new('Malachi', [Card.new("A", "S"), Card.new("A", "H"), Card.new("A", "D"), Card.new("A", "C")])
    player.pair_cards
    expect(player.cards_left).to eq 0
    expect(player.matches.length).to eq 1
  end

  it 'can remove all cards of a rank' do
    player = Player.new('Malachi', [Card.new("A", "S"), Card.new("A", "H"), Card.new("A", "D"), Card.new("A", "C")])
    player.remove_cards_by_rank('A')
    expect(player.cards_left).to eq 0
  end

  it 'set the hand' do
    player = Player.new('Malachi', [Card.new("A", "S"), Card.new("A", "H"), Card.new("A", "D"), Card.new("A", "C")])
    card1 = Card.new("4", "S"), card2 = Card.new("2", "H"), card3 = Card.new("5", "D"), card4 = Card.new("A", "C")
    player.set_hand([card1, card2, card3, card4])
    expect(player.player_hand).to eq [card1, card2, card3, card4]
  end

  it 'has points' do
    player = Player.new('Malachi', [Card.new("A", "S"), Card.new("A", "H"), Card.new("A", "D"), Card.new("A", "C")])
    player.pair_cards
    expect(player.points).to eq 1
  end

  it "returns json hash" do
    player = Player.new('Malachi', [Card.new("A", "S"), Card.new("A", "H"), Card.new("A", "D"), Card.new("A", "C")])
    expect(player.as_json).to include_json name: 'Malachi'
    expect(player.as_json).to include_json matches: []
    expect(player.as_json).to include_json cards: [{rank: "A", suit: "S", value: "Ace of Spades"}]
  end

  it "returns json hash" do
    player = Player.new('Malachi', [Card.new("A", "S"), Card.new("A", "H"), Card.new("A", "D"), Card.new("A", "C")]).as_json
    player = Player.from_json(player)
    expect(player.class).to eq Player
    expect(player.player_hand).to_not eq []
  end
end
