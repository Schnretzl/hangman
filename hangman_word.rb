require 'yaml'

class HangmanWord
  MAX_GUESSES = 6
  attr_accessor :word

  def initialize(word = generate_word())
    @word = word
    @guesses = 0
    @answer_letter_array = word.chars()
    @guess_letter_array = Array.new(@word.length, '_')
    @wrong_guesses = []
  end

  def make_guess(letter)
    if @word.include?(letter)
      @guess_letter_array = @guess_letter_array.zip(@answer_letter_array).map { |guess_letter, word_letter| word_letter == letter ? letter : guess_letter }
    else
      @wrong_guesses << letter
      @guesses += 1
    end
  end

  def display_guess
    puts @guess_letter_array.join(' ')
    puts "Letters guessed: #{@wrong_guesses.join(', ')}"
  end

  def win?
    @guess_letter_array == @answer_letter_array
  end

  def lose?
    @guesses == MAX_GUESSES
  end

  def save(filename = "hangman.yaml")
    File.open(filename, 'w') do |file|
      file.write(to_yaml)
    end
  end

  def self.load(filename = "hangman.yaml")
    if File.exist?(filename)
      yaml_data = File.read(filename)
      YAML.load(yaml_data)
    else
      puts "Error: No such file or directory"
      nil
    end
  end

  private

  def generate_word()
    words = File.readlines("google-10000-english-no-swears.txt", 'r').map(&:chomp)
    words = words.select { |word| word.length >= 5 && word.length <= 12 }
    words.sample
  end
end
