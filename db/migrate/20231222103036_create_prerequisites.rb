class CreatePrerequisites < ActiveRecord::Migration[7.0]
  def change
    create_table :prerequisites do |t|
      t.references :course, foreign_key: {to_table: :courses}, null: false
      t.references :prerequisite_course, foreign_key: {to_table: :courses}, null: false

      t.timestamps
    end
  end
end
