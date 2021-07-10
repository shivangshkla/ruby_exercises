def caesar_cipher(string,number)
  letter = string.split('')
  letter.map! do |character| 
    if(character >= 'a' && character <= 'z')
      character = character.ord - 'a'.ord 
      character = character + number
      character =  character % 26
      character =  'a'.ord  + character
      character = character.chr
      elsif(character >= 'A' && character <= 'Z')
      character = character.ord - 'A'.ord 
      character = character + number
      character =  character % 26
      character =  'A'.ord  + character
      character = character.chr
    else
    character = character
    end
  end
 puts string = letter.join('')
end
caesar_cipher("What a string!",5)
