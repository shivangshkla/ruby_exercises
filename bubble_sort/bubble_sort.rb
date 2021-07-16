def bubble_sort(array)
    length = array.length
    for i in 0..length-1
      for j in 0..length-2
        if(array[j] >= array[i])
          temp = array[j]
          array[j] = array[i]
          array[i] = temp
        end
      end
    end
  print array
  end
  bubble_sort([4,3,78,2,0,2])