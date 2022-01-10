class CreateBans < ActiveRecord::Migration[7.0]
  def change
    create_table :bans do |t|
      t.references :user, null: false, foreign_key: {on_delete: :cascade}
      t.date :end_at
      t.text :reason

      t.timestamps
    end
  end
end
