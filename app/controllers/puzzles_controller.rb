require 'digest'

# The PuzzlesController is responsible for managing puzzles.
# It includes methods to show a puzzle and find a number that,
# when appended to the puzzle input, generates an MD5 hash starting with five zeroes.
class PuzzlesController < ApplicationController
  def index
    @puzzle = Puzzle.find(1).input
    # Rails.logger.debug @puzzle.inspect
  end

  def new
    @puzzle = Puzzle.new
  end

  def show
    @puzzle = Puzzle.find(params[:id])
    if @puzzle.day == '4'
      @result = solve_day_4(@puzzle.input)
    elsif @puzzle.day == '5'
      @result = solve_day_5(@puzzle.input)
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

  def solve_day_4(input)
    result = 0

    loop do
      hash = Digest::MD5.hexdigest(input + result.to_s)
      return result if hash.start_with?('000000')

      result += 1
    end
  end

  def solve_day_5(input)
    ## place your code here
  end

  def puzzle_params
    params.require(:puzzle).permit(:year, :day, :part, :input)
  end
end
