class Card
  attr_accessor :rank, :suit

  def initialize(rank, suit)
    self.rank = rank
    self.suit = suit
  end

  def card_name
    return "#{self.rank} of #{self.suit}"
  end

  def output_card
    print card_name
  end

  def self.random_card
    Card.new(rand(10), :spades)
  end
end

class Deck

  def initialize()
    @cards = []
    suits = ["spades", "heart", "diamond", "club"]
    ranks = ["ace", 2, 3, 4, 5, 6, 7, 8, 9, 10, "jack", "queen", "king"]
    for suit in suits 
      for rank in ranks
        @cards << Card.new(rank, suit)
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def deal
    if @cards.empty?
      nil  
    else
      card = @cards[0]
    @cards.shift(1)
      return card
    end
  end

  def output()
    count = 0
    for item in @cards
        count = count + 1
        puts  "#{count}: #{item.card_name}"
    end
  end

end

puts "***** get a deck"
deck = Deck.new
puts "***** shuffle"
deck.shuffle
puts "***** output deck"
deck.output
puts "***** deal"
top_card = deck.deal
puts "delt card = #{top_card.card_name}"
puts "***** output deck"
deck.output
