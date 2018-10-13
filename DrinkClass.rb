class Drink
  #ドリンクのID
  @@id = 1

  def initialize (name, price, quantity)
    #ドリンクのID
    @id = @@id
    #ドリンクの名前
    @name = name
    #ドリンクの値段
    @price = price
    #ドリンクの数
    @quantity = quantity

    #ドリンクのID増加
    @@id += 1
  end

  def get_id
    return @id
  end

  def get_price
    return @price
  end

  def get_name
    return @name
  end

  def get_quantity
    return @quantity
  end

  def update_quantity

    if @quantity == 0
      return false
    end

    @quantity -= 1

    return true
  end

end