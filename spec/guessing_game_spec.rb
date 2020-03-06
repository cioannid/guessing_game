# frozen_string_literal: true

require_relative '../lib/guessing_game'
require 'pry'

RSpec.describe GuessingGame do
  context 'when losing the game' do
    it 'gives five chances to the player before losing' do
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
        ^13\sis\stoo\slow!$\R
        ^Pick\sa\snumber\s1-100\s\(4\sguesses\sleft\):$\R
        ^49\sis\stoo\shigh!$\R
        ^Pick\sa\snumber\s1-100\s\(3\sguesses\sleft\):$\R
        ^12\sis\stoo\slow!$\R
        ^Pick\sa\snumber\s1-100\s\(2\sguesses\sleft\):$\R
        ^21\sis\stoo\slow!$\R
        ^Pick\sa\snumber\s1-100\s\(1\sguesses\sleft\):$\R
        ^42\sis\stoo\slow!$\R
        ^You\slost!\sThe\snumber\swas:\s43$\Z
      }x

      output = StringIO.new
      gg = GuessingGame.new(input: input, output: output, target: 43)

      gg.play

      expect(output.string).to match(regexp_output)
    end
  end

  context 'when winning the game' do
    it 'gives max 5 opportunities to the player until shes wins' do
      string_input = <<~INPUT
        13
        49
        12
        42
        21
      INPUT
      input = StringIO.new(string_input)

      regexp_output = %r{
        \APick\sa\snumber\s1-100\s\(5\sguesses\sleft\):$\R
        ^13\sis\stoo\slow!$\R
        ^Pick\sa\snumber\s1-100\s\(4\sguesses\sleft\):$\R
        ^49\sis\stoo\shigh!$\R
        ^Pick\sa\snumber\s1-100\s\(3\sguesses\sleft\):$\R
        ^12\sis\stoo\slow!$\R
        ^Pick\sa\snumber\s1-100\s\(2\sguesses\sleft\):$\R
        ^You\swon!$\Z
      }x

      output = StringIO.new
      gg = GuessingGame.new(input: input, output: output, target: 42)

      gg.play

      expect(output.string).to match(regexp_output)
    end
  end
end
