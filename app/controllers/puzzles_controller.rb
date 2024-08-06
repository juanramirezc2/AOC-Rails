require 'digest'

# The PuzzlesController is responsible for managing puzzles.
# It includes methods to show a puzzle and find a number that,
# when appended to the puzzle input, generates an MD5 hash starting with five zeroes.
class PuzzlesController < ApplicationController
  def index
    @puzzles = Puzzle.all
    # Rails.logger.debug @puzzle.inspect
  end

  def new
    @puzzle = Puzzle.new
  end

  def show
    @puzzle = Puzzle.find(params[:id])
    if @puzzle.day == '4'
      @result = solve_day_four(@puzzle.input)
    elsif @puzzle.day == '5'
      @result = solve_day_five(@puzzle.input)
    end
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)

    if @puzzle.save
      redirect_to @puzzle
    else
      render :new, status: :unprocessable_entity
    end
  end

  def solve_day_four(input)
    result = 0

    loop do
      hash = Digest::MD5.hexdigest(input + result.to_s)
      return result if hash.start_with?('000000')

      result += 1
    end
  end

  def solve_day_five(input, part)
    input_array = input.split("\n")
    if part == 1
      nice_words = 0
      input_array.each do |line|
        # check if line includes at least 3 vovels
        next unless line.scan(/[aeiou]/).count >= 3
        # check if line includes at least one letter that appears twice in a row
        next unless line.match(/(.)\1/)
        # check if line does not include any of the following strings: ab, cd, pq, or xy
        next if line.match(/ab|cd|pq|xy/)

        nice_words += 1
      end

      nice_words
    elsif part == 2
      nice_words = 0
      input_array.each do |line|
        # check if line includes at least one letter that appears twice in a row
        next unless line.match(/(..)\1/)
        # check if line does not include any of the following strings: ab, cd, pq, or xy
        next if line.match(/ab|cd|pq|xy/)

        nice_words += 1
      end
      nice_words
    end
  end

  def puzzle_params
    params.require(:puzzle).permit(:year, :day, :part, :input)
  end
end
