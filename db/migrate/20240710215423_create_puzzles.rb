class CreatePuzzles < ActiveRecord::Migration[7.1]
  def change
    create_table :puzzles do |t|
      t.string :year
      t.string :day
      t.string :part
      t.text :input

      t.timestamps
    end
  end
end
