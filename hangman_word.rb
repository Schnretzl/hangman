require 'yaml'

class HangmanWord
  SAVE_DIRECTORY = 'saves'.freeze
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
    puts "Wrong guesses remaining: #{MAX_GUESSES - @guesses}"
  end

  def win?
    @guess_letter_array == @answer_letter_array
  end

  def lose?
    @guesses == MAX_GUESSES
  end

  def already_guessed?(letter)
    @wrong_guesses.include?(letter)
  end

  def save(filename = 'hangman.yaml')
    Dir.mkdir(SAVE_DIRECTORY) unless File.directory?(SAVE_DIRECTORY)
    File.open(File.join(SAVE_DIRECTORY, filename), 'w') do |file|
      file.write(to_yaml)
    end
  end

  def self.load(filename = 'hangman.yaml')
    if File.exist?(File.join(SAVE_DIRECTORY, filename))
      yaml_data = File.read(File.join(SAVE_DIRECTORY, filename))
      YAML.load(yaml_data)
    else
      puts "Error: No such file or directory"
      nil
    end
  end

  private

  def generate_word()
    file = File.open('google-10000-english-no-swears.txt', 'r')
    potential_words = []

    begin
      while (line = file.readline)
        if line.chomp.length >= 5 && line.chomp.length <= 12
          potential_words << line.chomp
        end
      end
    rescue EOFError
    ensure
      file.close
    end
    potential_words.sample.downcase
  end
end
