require 'colorize'
class Mastermind
  @@code = []
  @@game = true
  @@player = []
  COLORPEG = -1
  WHITEPEG = -2
  def Mastermind.code_breaker
    while @@code.length != 4 
      digit = Random.new  
      digit = digit.rand(1..6)
      @@code =  @@code.append(digit)
    end
    game_start("player")
  end
  def Mastermind.code_maker
    puts "Create your code:".green
    code = gets.chomp
    if code.length != 4
      puts "Wrong Input! Enter 4-digit code".red
      code_maker
    else
      code = code.split('')
    code.map do |digit|
      if (1..6).include?(digit.to_i)
        @@code.append(digit.to_i)
      else
        puts "Wrong Input! Enter numbers between 1 to 6".red
        code_maker
      end
    end
    game_start("computer")
    end
  end
  def Mastermind.game_start(codebreaker)
    turns = 1
    while @@game && turns <= 12
      print "#{turns}: "
      if codebreaker == "player"
        player_guess
      else 
        computer_guess
      end
      turns += 1
    end
    if @@game == false
      print @@code
      puts
      puts "#{codebreaker} Won!".blue
    else 
      print @@code
      puts
      puts "#{codebreaker} lost".yellow
    end
  end
  def Mastermind.computer_guess
    puts "Computer's guess code".green
    while @@player.length != 4 
      digit = Random.new  
      digit = digit.rand(1..6)
      @@player =  @@player.append(digit)
    end
    temp = []
    @@player.map do |digit|
      temp.append(digit)
    end
    @@player.map do |digit|
      print digit
    end
    puts
    check_code
    @@player.each_with_index do |digit,index|
	  num = Random.new
      if digit == COLORPEG
        @@player[index] = temp[index] 
	  elsif digit > 7
	  
	  else  
        @@player[index] = num.rand(1..6)
      end
    end
	
  end
  def Mastermind.player_guess
    puts "Guess the 4-digit code:".blue
    player_code = gets.chomp
    if player_code.length != 4
      puts "Wrong Input! Enter 4-digit code".red
      player_guess
    else
      @@player = player_code.split('')
    @@player.map do |digit|
      if (1..6).include?(digit.to_i)
      else
        puts "Wrong Input! Enter numbers between 1 to 6".red
        player_guess
      end
    end
    check_code
    end
  end
  def Mastermind.check_code
    score = []
    code = []
    @@code.map do |element|
      code.append(element)
    end
    @@player.each_with_index do |digit,index|
      code.each_with_index do |number,position|
        if number == digit.to_i && position == index
          print "*".red
          score.append("*")
          code[position] = 0
          @@player[position] = COLORPEG
          break
        end
      end
    end
    @@player.each_with_index do |digit,index|
      code.each_with_index do |number,position|
        if number == digit.to_i && position != index
          print "*".white
          score.append(".")
          code[position] = 0
          break
        end
      end
    end
    puts
    if score == ["*","*","*","*"]
      @@game = false
    end
  end
  def Mastermind.maker_or_breaker
    puts "Type 1 to be code-maker".green
    puts "Type 2 to be code-breaker".yellow
    choice = gets.chomp.to_i
    if choice == 1
      code_maker
    elsif choice == 2
      code_breaker
    else
      puts "Wrong input".red
      maker_or_breaker
    end
  end
  maker_or_breaker
end