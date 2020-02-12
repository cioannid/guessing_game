# frozen_string_literal: true

class GuessingGame
  attr_reader :input, :output

  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
  end

  def play
    @number = rand(1..100)
    @guess = nil

    5.downto(1) do |remaining_guesses|
      break if @guess == @number

      output.puts "Pick a number 1-100 (#{remaining_guesses} guesses left):"
      @guess = input.gets.to_i
      check_guess
    end

    announce_result
  end

  private

  def check_guess
    if @guess > @number
      output.puts "#{@guess} is too high!"
    elsif @guess < @number
      output.puts "#{@guess} is too low!"
    end
  end

  def announce_result
    if @guess == @number
      output.puts 'You won!'
    else
      output.puts "You lost! The number was: #{@number}"
    end
  end
end

GuessingGame.new.play if __FILE__.end_with?($PROGRAM_NAME)
