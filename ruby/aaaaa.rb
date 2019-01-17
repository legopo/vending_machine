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

class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  attr_reader :total, :sale_amount

  def initialize
    @total = 0 #投入金額
    @sale_amount = 0 #売り上げ
    @drinks = {}
    5.times { store(Drink.coke) }
    5.times { store(Drink.water) }
    5.times { store(Drink.redbull) }
  end

  def insert
    puts "お金を入れてください"
    amount = gets.chomp.to_i
    if MONEY.include?(amount)
      @total += amount
      puts "投入金額: #{@total} 円"
      re_insert
    else
      puts "使用可能な貨幣を入れてください"
      puts "お釣り: #{amount} 円"
      re_insert
    end
  end

  def re_insert
    puts "もう一度お金入れますか？"
    puts "1: はい"
    puts "2: いいえ"
    puts "3: 払い戻し"

    choice = gets.chomp.to_i

    if choice == 1
      insert
    elsif choice == 2
      puts "投入金額: #{@total} 円"
    elsif choice == 3
      puts "お釣り: #{@total} 円"
    else
      re_insert
    end
  end

  def pay_back
    puts "お釣り: #{@total} 円"
    @total = 0
  end

  def info
      @drinks.each do |key, value|
        puts "#{key}:#{value[:price]} 円 残り:#{value[:drinks].length} 個"
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
    unless @drinks.has_key?(drink.name)
      @drinks[drink.name] = { price: drink.price ,drinks: [] }
    end
    @drinks[drink.name][:drinks].push(drink)
  end
end
