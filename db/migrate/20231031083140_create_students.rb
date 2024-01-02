class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :first_name, null: false
      t.string :father_name, null: false
      t.string :last_name, null: false
      
      t.string :gender, null: false

      t.string :phone, null: false
      t.hstore :address, null:false
      t.string :nationality, null: false

      t.date :dob, null: false
      t.string :martial_status, null: false

      t.integer :class_year, null:false, default: 1
      t.integer :semester, null: false, default: 1
      t.string :admission_type, null: false

      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
