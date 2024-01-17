class CreateRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :registrations do |t|
      t.references :student, null: false, foreign_key: true
      t.decimal :grade
      t.string :academic_year
      t.string :class_uear
      t.string :semester
      t.references :teaching, null: false, foreign_key: true

      t.timestamps
    end
  end
end
