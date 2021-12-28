class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.integer :value
      t.integer :position
      t.belongs_to :participant
      t.belongs_to :room

      t.timestamps
    end
  end
end
