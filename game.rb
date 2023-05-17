require_relative 'word'

def get_valid_guess
  puts 'Guess?'
  loop do
    input = gets.chomp
    if input.length == 1 && input =~ /[a-zA-Z]/
      return input.downcase
    else
      puts 'Please enter a single alphabetic letter'
    end
  end
end

def main
  word = new.HangmanWord()
  puts 'Let\'s play a game of hangman!'

  loop do
    guess = get_valid_guess
    word.make_guess
    display_guessed_letters
    if win?
      puts 'You win!'
      break
    end
    if lose?
      puts 'You lose!'
      break
    end
  end
end
