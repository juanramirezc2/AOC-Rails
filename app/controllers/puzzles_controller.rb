class PuzzlesController < ApplicationController
  def index
    @puzzle = Puzzle.find(1)
    Rails.logger.debug @puzzle.inspect
  end
end
