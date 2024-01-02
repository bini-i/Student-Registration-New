class CreateSections < ActiveRecord::Migration[7.0]
  def change
    create_table :sections do |t|
      t.string :section_name
      t.references :course, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
