def substrings(string,array)
    string_array = string.split(' ')
    result = Hash.new(0)
    array.map do |temp|
      string_array.map do |word|
        if (word.downcase.include?temp)
          result[temp] += 1
        end
      end
    end
  puts result
  end
  dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
  substrings("Howdy partner, sit down! How's it going?", dictionary)