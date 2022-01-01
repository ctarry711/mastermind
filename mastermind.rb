class Game
  attr_reader :code

  def initialize
    @code = Array.new
    4.times {@code.push(rand(6) + 1)}
    @turns = 12
  end

  def get_player_guess
    loop do 
      puts "Please input four numbers between 1-6 seperated by a space (ex. '1 2 3 4') to make a guess"
      input = gets.chomp.split(" ").map { |i| i.to_i } 
      if input.length == 4 && input.all? {|i| i.class == Integer && i.between?(1,6)}
        return input
      else
        puts "That is not a valid input"
      end
    end
  end

  def check_guess(guess)
    black_pegs = 0
    white_pegs = 0
    @code.each_with_index do |code_peg, index|
      if code_peg == guess[index]
        black_pegs += 1 
        guess[index] = nil #removes that guess so that it can't be counted twice
      end
    end
    @code.each do |code_peg|
      if guess.any?(code_peg)
        white_pegs += 1
        guess[guess.index(code_peg)] = nil #removes that guess so that it can't be counted twice
      end
    end
    return black_pegs, white_pegs
  end

  def play
    puts "Let's play mastermind! The computer has chosen a secret code. You have #{@turns} to guess the correct code"
    puts "Shh, don't tell him, but the code is #{@code}"
    while @turns > 0
      black_pegs, white_pegs = check_guess(get_player_guess)
      if black_pegs == 4
        puts "That is correct! You have cracked the code!"
        break
      end
      puts "#{black_pegs} guesses are the correct value and in the correct location"
      puts "#{white_pegs} guesses are the correct value but in the incorrect location"
      @turns -= 1
      puts "You have #{@turns} remaining turns to guess the correct code"
    end
    "You have run out of turns. Please try again!"
  end
end

game = Game.new
game.play
