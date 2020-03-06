# frozen_string_literal: true

class GuessingGame
  ATTEMPTS_LIMIT = 5

  attr_reader :input, :output

  def initialize(input: $stdin, output: $stdout, number: rand(1..100))
    @input = input
    @output = output
    @number = number
  end

  def play
    guess = nil
    ATTEMPTS_LIMIT.downto(1) do |remaining_guesses|
      announce "Pick a number 1-100 (#{remaining_guesses} guesses left):"
      guess = input.gets.to_i
      break if correct_guess?(guess, @number)
      announce hint(guess, @number)
    end
    announce result(correct_guess?(guess, @number), @number)
  end

  def correct_guess?(guess, number)
    number == guess
  end

  private

  def hint(guess, number)
    if guess > number
      "#{guess} is too high!"
    elsif guess < number
      "#{guess} is too low!"
    end
  end

  def result(successful_guess, number)
    if successful_guess
      'You won!'
    else
      "You lost! The number was: #{number}"
    end
  end

  def announce(announcement)
    output.puts announcement
  end
end

GuessingGame.new.play if __FILE__.end_with?($PROGRAM_NAME)
