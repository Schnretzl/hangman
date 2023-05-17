class hangman_word
    attr_accessor :word, 

    def initialize(word)
        @word = word
        @guesses = 0
        @answer_letter_array = word.split
        @guess_letter_array = Array.new(@word.length, '_')

    end

    def make_guess(letter)
        if !@word.include?(letter)
            @guesses += 1
        else
            @guess_letter_array.zip(@answer_letter_array).map { |guess_letter, word_letter| word_letter == letter ? letter : guess_letter }
        end
    end
end