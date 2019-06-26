CARD_RANKS = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
CARD_SUITS = ["D", "H", "C", "S"]
class CardDeck
  attr_reader :cards
  def initialize(cards: "No cards passed in")
    @cards = cards
    if @cards == "No cards passed in"
      create_deck
    end
  end

  def create_deck
    @cards = []
    CARD_SUITS.each do |suit|
      CARD_RANKS.each do |rank|
        @cards.push(Card.new(rank: rank, suit: suit))
      end
    end
  end

  def cards_left
    cards.length
  end

  def refill player
    5.times do |index|
      card = take_card
      player.take([card]) if card
    end
  end

  def take_card
    if has_cards?
      @cards.pop()
    end
  end

  def deal(num)
    arr = []
    num.times do |i|
      arr.push([])
    end
    5.times do |index|
      arr.each do |deck|
        deck.push(take_card)
      end
    end
    arr
  end

  def remove_all_cards_from_deck
    @cards = []
  end

  def has_cards?
    if cards_left > 0
      return true
    end
    false
  end

  def shuffle
    @cards.shuffle!
  end

  def as_json options = {}
    {'cards' => cards.map(&:as_json)}
  end

  def self.from_json(obj)
    cards = obj['cards'].map do |c|
      Card.from_json(c)
    end
    CardDeck.new(cards: cards)
  end
end
