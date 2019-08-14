class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.datetime :deadline
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.references :user, foreign_key: true
    end
  end
end
