def maxProfit(array)
    max = 0
      array.map do |cost|
        array2 = array[array.find_index(cost) + 1,array.length]
        temp = []
        for i in array2
          temp.append(i - cost)
        end
        if(temp.max != nil)
          if(temp.max > max)
            max = temp.max
          end
        end
      end
   max
    end
  def stock_picker(array)
    profit = maxProfit(array)
    result = []
    array.map do |costPrice|
      array.map do |sellPrice|
        if((sellPrice-costPrice) == profit)
          result.append(array.find_index(costPrice))
          result.append(array.find_index(sellPrice))
        end
      end
    end
    print result
  end
    stock_picker([17,3,6,9,15,8,6,1,10])