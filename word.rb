class HangmanWord
  attr_accessor :word

  def initialize(word = generate_word())
    @word = word
    @guesses = 0
    @answer_letter_array = word.chars()
    @guess_letter_array = Array.new(@word.length, '_')
  end

  def make_guess(letter)
    if @word.include?(letter)
      @guess_letter_array = @guess_letter_array.zip(@answer_letter_array).map { |guess_letter, word_letter| word_letter == letter ? letter : guess_letter }
    else
      @guesses += 1
    end
  end

  def win?
    @guess_letter_array == @answer_letter_array
  end

  def lose?
    @guesses == 6
  end

  private

  def generate_word()
    words = File.readlines("google-10000-english-no-swears.txt", 'r').map(&:chomp)
    words = words.select { |word| word.length >= 5 && word.length <= 12 }
    words.sample
  end
end
