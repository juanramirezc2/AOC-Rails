class PuzzlesController < ApplicationController
  def index
    @puzzle = Puzzle.find(1).input
    # Rails.logger.debug @puzzle.inspect
  end

  def show
    @puzzle = Puzzle.find(params[:id])
  end
end
