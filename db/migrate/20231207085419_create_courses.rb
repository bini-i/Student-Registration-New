class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :course_name
      t.integer :credit_hour
      t.integer :ects
      t.references :prerequisite, null: true, default: nil, foreign_key: {to_table: :courses}
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
