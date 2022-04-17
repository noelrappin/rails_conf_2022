class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :initials
      t.string :slug

      t.timestamps
    end
  end
end
