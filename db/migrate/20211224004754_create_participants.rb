class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.belongs_to :room
      t.string :first_name
      t.string :last_name
      t.string :place_of_study

      t.timestamps
    end
  end
end
