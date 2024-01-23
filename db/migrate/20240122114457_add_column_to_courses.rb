class AddColumnToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :class_year, :integer
    add_column :courses, :semester, :integer
  end
end
