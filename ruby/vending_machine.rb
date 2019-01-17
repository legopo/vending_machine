# require '/Users/michishitatsubasa/workspace/Vending_Machine_Practice/lib/drink'
require_relative 'drink'

class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  DEFAULT_STOCK_NUMBER = 5

  def initialize
    @slot_money = 0
    # @sales = 0
    # @coke_stock = DEFAULT_STOCK_NUMBER
    # @red_bull_stock = DEFAULT_STOCK_NUMBER
    # @water_stock = DEFAULT_STOCK_NUMBER
    # @coke = Drink.new("コーラ", 120)
    # @red_bull = Drink.new("レッドブル",200)
    # @water = Drink.new("水", 100)
    @stocks = {
      coke: {
        drink: Drink.coke,
        count: DEFAULT_STOCK_NUMBER
      },
      red_bull: {
        drink: Drink.red_bull,
        count: DEFAULT_STOCK_NUMBER
      },
      water: {
        drink: Drink.water,
        count: DEFAULT_STOCK_NUMBER
      }
    }
  end

  def current_slot_money
    @slot_money
  end

  def initialize_slot_money
    @slot_money = 0
  end

# お金を投入できる、複数回投入できる
  def slot_money(money)
    return false unless MONEY.include?(money)
    @slot_money += money
    # if MONEY.include?(money)
    #   @slot_money += money
    #   puts "現在#{@slot_money}円投入されています"
    # else
    #   puts "想定外のお金です#{money}円返却します"
    # end
  end

# 投入金額と商品の金額を差し引いた金額が返却できる
  def return_money
    @return_money = @slot_money - @drink.price
    puts @return_money
    @slot_money = 0
  end

# 買えるものを表示させることができる
  def select_view
    puts available_drinks.map.with_index(1) { |drink, index|
      "#{index}:#{drink.to_s}"
    }.join("\n")
    # if @slot_money >= Drink.red_bull.price
    #   puts [Drink.coke, Drink.red_bull, Drink.water].map.with_index(1) { |drink, index|
    #     "#{index}:#{drink.to_s}"
    #   }.join("\n")
    #   # puts "1:コーラ#{Drink.coke.price}円 \n2:レッドブル#{Drink.red_bull.price}円 \n3:水#{Drink.water.price}円"
    # elsif @slot_money >= Drink.coke.price && @slot_money < Drink.red_bull.price
    #   puts "1:コーラ#{Drink.coke.price}円\n3:水#{Drink.water.price}円"
    # elsif @slot_money >= Drink.water.price && @slot_money < Drink.coke.price
    #   puts "3:水#{Drink.water.price}円"
    # else
    #   puts "買えるものがありません"
    # end
  end

  def available_drinks
    [Drink.coke, Drink.red_bull, Drink.water].select do |drink|
      @slot_money >= drink.price
    end
  end

  # 購入することができる
  # 買ったら自動で在庫数が動くメソッドを作る
  def purchase(drink_name)
    return nil unless can_purchase_drink?(drink_name)
    decrement_stock(drink_name)
    puts_refund(drink_name)
    initialize_slot_money
    @stocks[drink_name][:drink]
  end

  def decrement_stock(drink_name)
    @stocks[drink_name][:count] -= 1
  end

  def puts_refund(drink_name)
    puts "#{@slot_money -= @stocks[drink_name][:drink].price} 円返金されました"
  end

  def can_purchase_drink?(drink_name)
    @stocks[drink_name][:count] >= 1 && @slot_money >= @stocks[drink_name][:drink].price
  end

# 買ったもの(商品)をだすことができる、switchメソッドで在庫が減ったものが出力される
# お釣りを返却する
  # def pull_drink_money
  #   puts @drink.name
  #   puts @slot_money -= @drink.price
  #   @slot_money = 0
  # end
# 在庫情報が見られる
  def stock_drink
    stocks = @stocks.map do |_, value|
      "#{value[:drink].name}が#{value[:count]}個"
    end
    puts "在庫情報＊#{stocks.join('、')}"
    # puts "在庫情報＊#{Drink.coke.name}が#{@coke_stock}個、#{Drink.red_bull.name}が#{@red_bull_stock}個、#{Drink.water.name}が#{@water_stock}個"
  end
end

if $0 == __FILE__
  vm = VendingMachine.new
  money = 500
  if vm.slot_money(money)
    puts "#{money}円入りました"
  else
    puts "想定外のお金が入ったので返却されました"
  end
  puts "現在: #{vm.current_slot_money}円 入ってます"
  vm.select_view
  drink = vm.purchase(:coke)
  if drink
    puts "#{drink.name}を買いました"
  else
    puts "ドリンクを買えませんでした"
  end
  vm.stock_drink
end
