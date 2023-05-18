require_relative 'hangman_word'

def get_valid_guess(word)
  puts 'Enter guess, or (1)to save game, or (2)to load game:'
  loop do
    input = STDIN.gets.chomp
    if input.length == 1 && input =~ /[a-zA-Z12]/
      if word.already_guessed?(input)
        puts 'Letter has already been guessed!'
        next
      end
      return input.downcase
    else
      puts 'Please enter 1, 2, or a single alphabetic letter:'
    end
  end
end

def get_valid_filename
  puts "Enter a filename (default is 'hangman.yaml'):"
  loop do
    input = STDIN.gets.chomp
    if input =~ /^[a-zA-Z0-9_.-]+$/ || input == ''
      return input.empty? ? 'hangman.yaml' : input
    else
      puts 'Invalid filename. Please enter a valid filename:'
    end
  end
end

def save_game(word)
  filename = get_valid_filename
  word.save(filename)
  puts "Game saved as #{filename}.  Press enter to quit."
  STDIN.gets.chomp
end

def load_game(word)
  filename = get_valid_filename
  word = HangmanWord.load_saved_game(filename)
  puts "Game loaded!  Press enter to continue."
  STDIN.gets.chomp
  word
end

def main
  word = HangmanWord.new()
  puts 'Let\'s play a game of hangman!'

  loop do
    word.display_guess
    guess = get_valid_guess(word)
    if guess == '1'
      save_game(word)
      break
    elsif guess == '2'
      word = load_game(word)
      next
    end

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
