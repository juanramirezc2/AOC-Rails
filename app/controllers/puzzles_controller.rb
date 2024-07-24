require 'digest'

# The PuzzlesController is responsible for managing puzzles.
# It includes methods to show a puzzle and find a number that,
# when appended to the puzzle input, generates an MD5 hash starting with five zeroes.
class PuzzlesController < ApplicationController
  def index
    @puzzle = Puzzle.find(1).input
    # Rails.logger.debug @puzzle.inspect
  end

  def show
    @puzzle = Puzzle.find(params[:id])
    @number, @md5_hash = find_number_and_hash(@puzzle.input)
  end

  private

  def find_number_and_hash(input)
    counter = 0

    loop do
      hash = Digest::MD5.hexdigest(input + counter.to_s)
      return counter, hash if hash.start_with?('000000')

      counter += 1
    end
  end
end
