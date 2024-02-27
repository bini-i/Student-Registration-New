class CreateTeachings < ActiveRecord::Migration[7.0]
  def change
    create_table :teachings do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.string :section
      t.integer :status

      t.timestamps
    end
  end
end
