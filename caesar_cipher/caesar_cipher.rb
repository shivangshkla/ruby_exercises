def caesar_cipher(string,number)
  letter = string.split("")
  letter.map! do |character|
    if ((character.ord >= 'a'.ord && character.ord <= 'z'.ord) || (character.ord >= 'A'.ord && character.ord <= 'Z'.ord) )
      #Check whether the character is a letter or symbol
      character = character.ord
      character = character + number
      if (character > 'z'.ord)
        #wrapping z to a
        character = character - 'z'.ord
        character = ('a'.ord - 1) + character
        character = character.chr
        elsif(character > 'Z'.ord && character < 'a'.ord)
        #wrapping Z to A
        character = character - 'Z'.ord
        character = ('A'.ord - 1) + character
        character = character.chr
      else
      character = character.chr
      end
    else
    character = character
    end
  end
puts string = letter.join("")
  end
caesar_cipher("What a string!",5)
