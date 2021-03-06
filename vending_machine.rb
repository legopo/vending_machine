class Drink
  attr_reader :price, :name

  def self.coke
    self.new 120, :coke
  end

  def self.redbull
    self.new 200, :redbull
  end

  def self.water
    self.new 100, :water
  end

  def initialize(price, name)
    @price = price
    @name = name
  end
end

class Money
  JAPANESE_MONEY = [1, 5, 10, 50, 100, 500, 1000, 5000, 10000]
  attr_reader :kind_of_money

  def self.value(kind_of_money)
    if JAPANESE_MONEY.include?(kind_of_money)
      self.new(kind_of_money)
    else
      puts "正しい金額を入れてください"
    end
  end

  def initialize(kind_of_money)
    @kind_of_money = kind_of_money
  end
end

class VendingMachine
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze
  attr_reader :total, :sale_amount

  def initialize
    @total = 0 #投入金額
    @sale_amount = 0 #売り上げ
    @drinks = {}
    5.times { store(Drink.coke) }
    5.times { store(Drink.water) }
    5.times { store(Drink.redbull) }
  end

  def insert(money)
    chosen_money = money.kind_of_money
    if AVAILABLE_MONEY.include?(chosen_money)
      @total += chosen_money
      puts "投入金額: #{@total} 円"
    else
      puts "使用可能な貨幣を入れてください"
      puts "お釣り: #{chosen_money} 円"
    end
  end

  def pay_back
    puts "返却: #{@total} 円"
    @total = 0
  end

  def info
    @drinks.each do |key, value|
      puts "#{key}: #{value[:price]} 円 残り: #{value[:drinks].length} 個"
    end
  end

  def purchase?(drink)
    @total >= drink.price && @drinks.length >= 1
  end

  def purchase(drink)
    if purchase?(drink)
      @drinks[drink.name][:drinks].pop
      @total -= drink.price
      @sale_amount += drink.price
      puts "残り:#{@total} 円"
    end
  end

  def store(drink)
    @drinks[drink.name] = { price: drink.price , drinks: [] } unless @drinks.include?(drink.name)
    @drinks[drink.name][:drinks].push(drink)
  end
end
