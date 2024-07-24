class Puzzle < ApplicationRecord
  validates :year, presence: true
  validates :day, presence: true
  validates :part, presence: true
  validates :input, presence: true, length: { minimum: 10 }
end
