class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.text :description
      t.string :size
      t.string :status
      t.string :slug
      t.integer :position
      t.references :project, null: false, foreign_key: true
      t.references :person, null: true, foreign_key: true
      t.timestamps
    end
  end
end
