require 'colorize'
class Hangman
    @@words = File.readlines('5desk.txt')
    @@guess = ""
    @@wrong = ""
    @@game = true
    @@player
    def Hangman.game_start
        puts "Type save to save game".blue
        while @@game == true && @@turns > 0
            puts "Already used wrong words: #{@@wrong}".red
            puts @@guess.green
            puts "Turns remaining: #{@@turns}".red
            puts "Enter a character from A-Z".blue
            @@player = gets.chomp
            if @@player == "save"
                save_game(@@word,@@guess,@@turns,@@wrong)
            end
            unless @@player.downcase.ord.between?(('a'.ord),('z'.ord)) &&  @@player.length == 1
                puts "Wrong Statement".red
                game_start
            end
            @@turns -= 1
            check_word(@@player)
            if @@guess == @@word
                puts "You Won!".yellow
                @@game = false
            elsif @@turns == 0
                puts "You lost!".yellow
                puts @@word
            end
        end
    end
    def Hangman.save_game(word,guess,turns,wrong)
        puts "Enter name for your save:".blue
        save_name = gets.chomp
        Dir.mkdir('saves') unless Dir.exist?('saves')
        filename = "saves/#{save_name}.txt"
        File.open(filename,'w') do |file|
            file.puts word
            file.puts guess
            file.puts turns
            file.puts wrong
        end
        puts "Your save (#{save_name}) has been saved".blue
        exit
    end
    def Hangman.load_game
        files = Dir.glob("saves/*.txt")
        if files.empty?
            puts "No save file exist"
            exit
        end
        files.map do |file|
            puts file[6..(file.length-11)+6]
        end
        save_name = "saves/" + gets.chomp + ".txt"
        if files.include?(save_name)
            files.map do |file|
                if file == save_name
                    contents = File.readlines(save_name)
                    @@word = contents[0].chomp
                    @@guess = contents[1].chomp
                    @@turns = contents[2].chomp.to_i
                    @@wrong = contents[3].chomp
                    game_start
                end
            end
        else
            puts "Wrong Statement".red
            load_game
       end
    end
    def Hangman.check_word(player)
        for j in 0..@@word.length-1 do
            if player.downcase == @@word[j]
                    @@guess[j] = @@word[j]
                    unless @@word.include?(player)
                        @@wrong += @@word[j].blue
                    end
            end
        end
        unless @@word.include?(player)
            @@wrong += player.red
        end
    end
    def Hangman.word_generator(words)
        word = words[rand(0..words.length)].chomp
        if word.length.between?(5,12)
            word
        else
            @@word = word_generator(@@words)
        end
    end
    @@word = word_generator(@@words)
    @@turns = @@word.length
    for i in 1..@@word.length do 
        @@guess += "_"
    end
    puts "Enter 1 for New Game".blue
    puts "Enter 2 to Load Game".blue
    choice = gets.chomp.to_i
    if choice == 1
        game_start
    elsif choice == 2
        load_game
    else
        puts "Wrong statement".red
    end
end