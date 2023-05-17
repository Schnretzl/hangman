class hangman_word
    attr_accessor :word, 

    def initialize(word)
        @word = word
        @guesses = 0

    end

    def make_guess(letter)
        if !@word.include?(letter)
            @guesses += 1
        else
            self.each(l)
        end
    end
end