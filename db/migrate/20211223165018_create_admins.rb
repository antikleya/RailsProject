class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.belongs_to :user
      t.belongs_to :room

      t.timestamps
    end
  end
end
