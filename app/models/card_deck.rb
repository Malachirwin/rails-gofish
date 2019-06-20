CARD_RANKS = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
CARD_SUITS = ["D", "H", "C", "S"]
class CardDeck
  def initialize
    @cards = []
    CARD_SUITS.each do |suit|
      CARD_RANKS.each do |rank|
        @cards.push(Card.new(rank, suit))
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

  def cards
    @cards
  end

  def take_card
    if has_cards?
      @cards.pop()
    end
  end

  def deal
    arr = [[], [], [], []]
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
    @cards = @cards.shuffle
  end

  def state
    cards.map { |c| c.value}
  end
end
