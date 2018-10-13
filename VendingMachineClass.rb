require_relative 'DrinkClass'

class VendingMachine

  def initialize
    #投入する金額
    @input_money = 0
    #投入した総金額
    @current_money = 0
    #払い戻す金額
    @change = 0
    #売り上げ
    @sales = 0
    #ドリンクのオブジェクトをセーブする配列
    @drink = []
    #ドリンクのオブジェクトを配列にセーブ
    @drink.push(Drink.new('コーラ', 120, 5))
    @drink.push(Drink.new('レッドブル', 200, 5))
    @drink.push(Drink.new('水', 100, 5))
  end

  #お金を販売機に投入
  def user_input_money

    # -1 -> 投入終了
    while @input_money != -1
      #お金を投入
      puts '投入する金額( -1 → 投入終了 )'
      @input_money = gets.chomp.to_i

      #条件：１円、５円、１０００円以外の札は投入できない
      if @input_money != -1 and @input_money <= 1000 and @input_money != 1 and @input_money != 5
        @current_money += @input_money
      end
      #条件に合わない場合は釣り銭にする
      if @input_money > 1000 and @input_money != 1 and @input_money != 5
        @change += @input_money
      end

      #現在の金額、釣り銭を出力
      puts '現在金額：' + @current_money.to_s
      puts '釣り銭：' + @change.to_s
    end

  end

  #ドリンク情報リストを出力
  def get_drink_info

    @drink_size =  @drink.length - 1

    #ドリンク情報出力
    for index in 0..@drink_size
        puts @drink[index].get_id.to_s + ' ' +  @drink[index].get_name + ' - ¥' +  @drink[index].get_price.to_s +
                 '  残り数→ ' + @drink[index].get_quantity.to_s
    end

  end

  #ドリンクを購入
  def purchase

      #ドリンク購入の繰り返し文
      while true

      #ドリンクのIDを入力
      puts '購入する商品の番号を入力( -1 → 購入終了、払い戻す )'
      @input_id = gets.chomp.to_i
      @find_index = @input_id - 1

      # -1なら終了
      if(@input_id == -1)
        break
      end

      begin

      #現在投入した金額より高いドリンクを選んだ場合メッセージ出力
      if @current_money < @drink[@find_index].get_price
        puts '現在金額が不足です。'
      else

        #現在金額をアップデート
        @current_money -= @drink[@find_index].get_price
        #ドリンクの数、売り上げをアップデート
        result = @drink[@find_index].update_quantity
        @sales += @drink[@find_index].get_price

        #ドリンクの在庫が不足する場合メッセージ出力
        if result == false
          puts '商品の在庫がないです。'
        end

        #ドリンクの数、売り上げを出力
        puts '売り上げ：' + @sales.to_s
        puts '現在金額：' + @current_money.to_s

      end
      #現在ドリンクのリスト出力
      self.get_drink_info

      rescue
        #ないIDを入力する場合メッセージを出力
        puts '存在しない商品番号です。'
      end

    end

  end

  #釣り銭を出力
  def refund
    #従来の釣り銭に現在の金額を加える
    @change += @current_money
    #釣り銭を出力
    puts '釣り銭：' + @change.to_s
  end

end

test = VendingMachine.new
test.user_input_money
test.get_drink_info
test.purchase
test.refund
