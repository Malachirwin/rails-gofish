require 'rails_helper'
describe 'Card' do
  it 'returns the suit' do
    card = Card.new(rank: "J", suit: 'H')
    expect(card.suit).to eq 'H'
  end

  it 'returns the rank' do
    card = Card.new(rank: "J", suit: 'H')
    expect(card.rank).to eq "J"
  end

  it "takes a card and turns in into the right thing for finding the card in cards folder" do
    card = Card.new(rank: "J", suit: 'H')
    card2 = Card.new(rank: "2", suit: 'H')
    expect(card.to_img_path).to eq "hj"
    expect(card2.to_img_path).to eq "h2"
  end

  it "returns the card value" do
    card = Card.new(rank: "2", suit: 'H')
    expect(card.value).to eq "2 of Hearts"
  end

  it "returns the rank value" do
    card = Card.new(rank: "J", suit: 'H')
    card2 = Card.new(rank: "4", suit: 'H')
    expect(card.rank_value).to eq "Jack"
    expect(card2.rank_value).to eq "4"
  end

  it "returns json hash" do
    card = Card.new(rank: "J", suit: 'H')
    card2 = Card.new(rank: "4", suit: 'H')
    hash1 = {"rank" => "J", "suit" => "H", 'value' => "Jack of Hearts"}
    hash2 = {"rank" => "4", "suit" => "H", "value" => "4 of Hearts"}
    expect(card.as_json).to eq hash1
    expect(card2.as_json).to eq hash2
  end

  it "returns a Card from a value" do
    card = Card.from_json(Card.new(rank: "J", suit: 'H').as_json)
    expect(card.class).to eq Card
    expect(card.rank).to eq "J"
    expect(card.suit).to eq "H"
  end
end
