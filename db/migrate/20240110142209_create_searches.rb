class CreateSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :searches do |t|
      t.string :student_id
      t.string :first_name
      t.string :father_name
      t.integer :admission_year
      t.integer :class_year
      t.integer :status

      t.timestamps
    end
  end
end
