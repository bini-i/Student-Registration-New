class CreateDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :departments do |t|
      t.string :dept_name

      t.timestamps
    end
  end
end
