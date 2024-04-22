require "./game.rb"

def validate_input (input)
  if input.size == 0
    return false
  end

  if !input.match?(/[A-Z]/)
    puts "[SYSTEM]: You should only use letters."
    return false
  end

  return true
end

game = Game.new
input = ""

puts game.choice

loop do
  if game.check_gameover
    puts "\n[SYSTEM]: You lost!"
    puts "[SYSTEM]: The correct answer was: #{game.choice}. Good luck next time!\n"
    break
  end

  if game.check_win
    puts "\n[SYSTEM]: YOU WON!!!!\n"
    break
  end

  if game.past_guesses.size > 0
    puts "[SYSTEM]: Past guesses: [#{game.past_guesses.join(", ")}]"
  end

  print "\nType your guess [character or word] (0 to quit the game): "
  input = gets.chomp.upcase

  puts "You typed: #{input}"

  if input == "0"
    break
  end

  if !validate_input(input)
    next
  end

  if input.size > 1
    game.guess_word(input)
  else
    game.guess_letter(input)
  end
end
