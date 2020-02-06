require_relative '../lib/guessing_game'

RSpec.describe GuessingGame do
  it 'works' do
    gg = GuessingGame.new

    expect { gg.play }.to output(/^Pick a number 1-100 \(5 guesses left\)/).to_stdout
  end
end
