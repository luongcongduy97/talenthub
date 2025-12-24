class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.text :message
      t.string :url
      t.datetime :read_at

      t.timestamps
    end
  end
end
