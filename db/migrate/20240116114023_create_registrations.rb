class CreateRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :registrations do |t|
      t.references :student, null: false, foreign_key: true
      t.decimal :grade
      t.integer :academic_year
      t.integer :class_year
      t.integer :semester
      t.references :teaching, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
