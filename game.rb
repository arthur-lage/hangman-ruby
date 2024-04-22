class Game
    attr_reader :choice, :past_guesses

    def initialize()
      @word_options = []

      File.foreach('./words.txt') do |line|
        @word_options.push(line.upcase.chomp)
      end

      @choice = @word_options.sample
      @answer = Array.new(@choice.size) {"_"}
      @health_points = 7
      @past_guesses = []
    end

    def get_letter_indexes(word, letter)
      indexes = []

      for i in 0..word.size - 1 do
        if(word[i] == letter)
          indexes.push(i)
        end
      end

      return indexes
    end

    def get_current_answer
      puts "[ #{@answer.join(" ")} ]"
    end

    def set_answer_as_word (word)
      for i in 0..word.size - 1 do
        @answer[i] = word[i]
      end
    end

    def handle_wrong_answer
      @health_points -= 1

      puts "[SYSTEM]: You guessed it wrong!"
      puts "[SYSTEM]: Current HP: #{@health_points}"
    end

    def update_answer(letter)
      letter_indexes = get_letter_indexes(@choice, letter)

      for i in letter_indexes
        @answer[i] = letter
      end
    end

    def guess_letter(letter)
      if @past_guesses.include? letter
        puts "[SYSTEM]: This letter was already used."
        return
      end

      if choice.include? letter
        puts "[SYSTEM]: You guessed it right!"
        update_answer(letter)
      else
        handle_wrong_answer
      end

      @past_guesses.push(letter)

      get_current_answer
    end

    def guess_word(word)
      if word == @choice
        set_answer_as_word(word)
      else
        handle_wrong_answer
      end
    end

    def check_gameover
      if @health_points == 0
        return true
      end

      return false
    end

    def check_win
      if @answer.join == @choice
        return true
      end

      return false
    end
  end
