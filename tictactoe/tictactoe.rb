class TicTacToe
	attr_accessor :name
	@@grid = [1,2,3,4,5,6,7,8,9]
	def initialize(name)
		@name = name
	end
   def TicTacToe.win_test(player,symbol)
      if @@grid[0] == symbol && @@grid[3] == symbol && @@grid[6] == symbol
			puts "#{player.name} Won"
			start
		end
		if @@grid[1] == symbol && @@grid[4] == symbol && @@grid[7] == symbol
			puts "#{player.name} Won"
			start
		end
		if @@grid[2] == symbol && @@grid[5] == symbol && @@grid[8] == symbol
			puts "#{player.name} Won"
			start
		end
		if @@grid[0] == symbol && @@grid[1] == symbol && @@grid[2] == symbol
			puts "#{player.name} Won"
			start
		end
	    if @@grid[3] == symbol && @@grid[4] == symbol && @@grid[5] == symbol
			puts "#{player.name} Won"
			start
		end
	    if @@grid[6] == symbol && @@grid[7] == symbol && @@grid[8] == symbol
			puts "#{player.name} Won"
			start
		end
	    if @@grid[0] == symbol && @@grid[4] == symbol && @@grid[8] == symbol
			puts "#{player.name} Won"
			start
		end
	    if @@grid[6] == symbol && @@grid[4] == symbol && @@grid[2] == symbol
			puts "#{player_1.name} Won"
			start
		end
   end
	def TicTacToe.player1_turn
		puts "#{@@player_1.name}'s turn:"
		x_place = gets.chomp.to_i
		if x_place >= 1 && x_place <= 9
			if @@grid[x_place - 1]=="X" || @@grid[x_place -1]=="O"
				puts "Place already occupied"
				player1_turn
			else
				@@grid[x_place - 1]="X"
			end
		else
			puts "Wrong Position"
			player1_turn
		end
		output
		win_test(@@player_1,"X")
		player2_turn
	end
	def TicTacToe.player2_turn
		puts "#{@@player_2.name}'s turn:"
		x_place = gets.chomp.to_i
		if x_place >= 1 && x_place <= 9
			if @@grid[x_place - 1]=="X" || @@grid[x_place -1]=="O"
				puts "Place already occupied"
				player2_turn
			else
				@@grid[x_place - 1]="O"
			end
		else
			puts "Wrong Position"
			player2_turn
		end
		output
		win_test(@@player_2,"O")
		player1_turn
	end
	def TicTacToe.start_game
		puts "Enter Player-1(X) name:"
		@@player_1 = TicTacToe.new(gets.chomp)
		puts "Enter Player-2(O) name:"
		@@player_2 = TicTacToe.new(gets.chomp)
		output
		first_turn = Random.new
		first_turn = first_turn.rand(1..2)
		if first_turn == 1
			player1_turn
		else
			player2_turn
		end	  
	end
	def TicTacToe.output
		column = 0
		@@grid.map do |position|
			column += 1
			if column % 3 == 0
				print "| #{position} | "
				puts
			else
				print "| #{position} | " 
			end
		end
	end
	def TicTacToe.start
		puts "Type 'start' to play"
		start = gets.chomp
		if start == 'start' 
			start_game
		else
			puts "Wrong statement"
			start
		end 
	end
	start
end