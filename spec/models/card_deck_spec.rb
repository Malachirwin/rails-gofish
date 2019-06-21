require 'rails_helper'

describe "CardDeck" do
  it 'should have 52 cards when created' do
    deck = CardDeck.new
    expect(deck.cards_left).to eq 52
  end

  it 'should deal cards to players' do
    deck = CardDeck.new
    cards = deck.deal(4)
    expect(cards.length).to eq 4
    expect(cards.first.length).to eq 5
    expect(cards.last.length).to eq 5
  end

  it 'returns true if deck has cards' do
    deck = CardDeck.new
    expect(deck.has_cards?).to eq true
  end

  it "shuffles cards" do
    deck = CardDeck.new
    cards = [*deck.cards]
    deck.shuffle
    expect(deck.cards).to_not eq(cards)
  end

  it 'removes all cards from deck' do
    deck = CardDeck.new
    expect(deck.cards_left).to eq 52
    expect(deck.remove_all_cards_from_deck).to eq []
  end

  it 'refills cards' do
    deck = CardDeck.new
    player = Player.new('Malachi')
    deck.refill player
    expect(player.cards_left).to eq 5
  end

  it 'refills cards unless there is no cards in deck' do
    deck = CardDeck.new
    player = Player.new('Malachi')
    (deck.cards_left - 2).times { |i| deck.take_card }
    deck.refill player
    expect(player.cards_left).to eq 2
  end

  it "returns json hash" do
    deck = CardDeck.new
    expect(deck.as_json).to include_json({cards: [{rank: 'A', suit: 'D', value: 'Ace of Diamonds'}]})
  end

  it "returns a Card from a value" do
    deck = CardDeck.new.as_json
    deck = CardDeck.from_json(deck)
    expect(deck.class).to eq CardDeck
    expect(deck.cards_left).to eq 52
  end
end
