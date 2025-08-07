class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees, id: :uuid do |t|
      t.string :name
      t.string :position
      t.references :company, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
