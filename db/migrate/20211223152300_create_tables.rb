class CreateTables < ActiveRecord::Migration[6.1]
  def change
    create_table :tables do |t|
      t.integer :width
      t.belongs_to :room

      t.timestamps
    end
  end
end
