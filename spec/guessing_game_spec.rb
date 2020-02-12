# frozen_string_literal: true

require_relative '../lib/guessing_game'
require 'pry'

RSpec.describe GuessingGame do
  it 'works' do
    string_input = <<~INPUT
      13
      49
      12
      21
      42
    INPUT
    input = StringIO.new(string_input)

    regexp_output = %r{
      \APick\sa\snumber\s1-100\s\(5\sguesses\sleft\):$\R
      ^13\sis\stoo\s(high|low)!$\R
      ^Pick\sa\snumber\s1-100\s\(4\sguesses\sleft\):$\R
      ^49\sis\stoo\s(high|low)!$\R
      ^Pick\sa\snumber\s1-100\s\(3\sguesses\sleft\):$\R
      ^12\sis\stoo\s(high|low)!$\R
      ^Pick\sa\snumber\s1-100\s\(2\sguesses\sleft\):$\R
      ^21\sis\stoo\s(high|low)!$\R
      ^Pick\sa\snumber\s1-100\s\(1\sguesses\sleft\):$\R
      ^42\sis\stoo\s(high|low)!$\R
      ^You\slost!\sThe\snumber\swas:\s\d?\d?\d$\Z
    }x

    output = StringIO.new
    gg = GuessingGame.new(input: input, output: output)

    gg.play

    expect(output.string).to match(regexp_output)
  end
end
