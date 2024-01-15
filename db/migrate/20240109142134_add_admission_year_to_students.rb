class AddAdmissionYearToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :admission_year, :integer, null: false
  end
end
