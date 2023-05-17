class HangmanWord
  attr_accessor :word

  def initialize(word)
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
end