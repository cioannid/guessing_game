# frozen_string_literal: true

class HighGuess
  attr_reader :guess

  def initialize(guess)
    @guess = guess
  end

  def correct?
    false
  end

  def hint
    "#{guess} is too high!"
  end
end

class LowGuess
  attr_reader :guess

  def initialize(guess)
    @guess = guess
  end

  def correct?
    false
  end

  def hint
    "#{guess} is too low!"
  end
end

class CorrectGuess
  attr_reader :guess

  def initialize(guess)
    @guess = guess
  end

  def correct?
    true
  end

  def hint; end
end

module Guess
  def self.for(guess, target)
    if guess < target
      LowGuess
    elsif guess > target
      HighGuess
    elsif guess == target
      CorrectGuess
    end.new(guess)
  end
end

class GuessingGame
  attr_reader :input, :output, :remaining_guesses

  def initialize(input: $stdin, output: $stdout, target: rand(1..100), attempts: 5)
    @input = input
    @output = output
    @number = target
    @remaining_guesses = attempts
    @won = false
  end

  def play
    new_interaction until over?
    announce result
  end

  def new_interaction
    announce "Pick a number 1-100 (#{remaining_guesses} guesses left):"
    new_attempt(input.gets.to_i)
    @remaining_guesses = remaining_guesses - 1
  end

  def new_attempt(guess_number)
    guess = Guess.for(guess_number, @number)
    if guess.correct?
      @won = true
    else
      announce guess.hint
    end
  end

  def won?
    @won
  end

  def over?
    won? || remaining_guesses.zero?
  end

  def result
    if won?
      'You won!'
    elsif over?
      "You lost! The number was: #{@number}"
    end
  end

  def announce(announcement)
    output.puts announcement
  end
end

GuessingGame.new.play if __FILE__.end_with?($PROGRAM_NAME)
