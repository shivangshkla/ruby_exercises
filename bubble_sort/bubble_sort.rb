def bubble_sort(array)
  length = array.length
  for i in 0..length - 1
    for j in 0..length-2
      if(array[j] > array[j+1])
        temp = array[j]
        array[j] = array[j+1]
        array[j+1] = temp
    end
    end
  length -= 1
  end
print array
  end
  bubble_sort([2,5,456,363,46,36,43634,634,6346,346,5])
