RANKS = { "A" => "Ace", "2" => "2", "3" => "3", "4" => "4", "5" => "5", "6" => "6", "7" => "7", "8" => "8", "9" => "9", "10" => "10", "J" => "Jack", "Q" => "Queen", "K" => "King" }
SUITS = { "D" => "Diamonds", "H" => "Hearts", "C" => "Clubs", "S" => "Spades" }

class Card
  def initialize rank:, suit:
    @rank = rank
    @suit = suit
  end

  def rank
    @rank
  end

  def suit
    @suit
  end

  def value
    "#{RANKS[rank]} of #{SUITS[suit]}"
  end

  def rank_value
    RANKS[rank]
  end

  def to_img_path
    "#{suit.downcase}#{rank.downcase}"
  end

  def as_json options = {}
    {'rank' => rank, 'suit' => suit, 'value' => value}
  end

  def self.from_json(hash)
    Card.new(rank: hash['rank'], suit: hash['suit'])
  end
end
