class Drink
  attr_reader :name, :price

  def initialize (name,price)
    @name = name
    @price = price
  end

  def to_h
    { name: @name,
    price: @price }
  end

  def to_s
    "#{@name}#{@price}円"
  end

  def self.coke
    @coke ||= Drink.new("コーラ", 120)
  end

  def self.red_bull
    @red_bull ||= Drink.new("レッドブル",200)
  end

  def self.water
    @water ||= Drink.new("水", 100)
  end
end
