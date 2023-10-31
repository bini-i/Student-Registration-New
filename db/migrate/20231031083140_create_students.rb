class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :father_name
      t.string :last_name
      t.string :gender
      t.string :martial_status
      t.string :nationality
      t.date :dob

      t.timestamps
    end
  end
end
