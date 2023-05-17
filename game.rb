require_relative 'hangman_word'

def get_valid_guess
  puts 'Guess?'
  loop do
    input = STDIN.gets.chomp
    if input.length == 1 && input =~ /[a-zA-Z]/
      return input.downcase
    else
      puts 'Please enter a single alphabetic letter'
    end
  end
end

def main
  word = HangmanWord.new()
  puts 'Let\'s play a game of hangman!'

  loop do
    word.display_guess
    guess = get_valid_guess
    word.make_guess(guess)
    if word.win?
      puts "You win!  The word was #{word.word}."
      break
    end

    if word.lose?
      puts 'You lose!'
      puts "The word was #{word.word}."
      break
    end
  end
end

main
