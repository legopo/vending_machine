$ irb
$ require "./vending_machine.rb"

スタート
  machine = VendingMachine.new

飲み物の情報を取得
  machine.info

お金を作る
 money = Money.price_x
 (xに作りたい金額を入れる)

お金の投入
  machine.insert(money)

払い戻し
  machine.pay_back

投入金額の表示
  machine.total

購入できるかの確認
  machine.purchase?(Drink.coke)
  machine.purchase?(Drink.redbull)
  machine.purchase?(Drink.water)

購入
  machine.purchase(Drink.coke)

売り上げ金額の表示
  machine.sale_amount

在庫補充
  一つ:  machine.store(Drink.coke)
  x個:   x.times { machine.store(Drink.coke) }
