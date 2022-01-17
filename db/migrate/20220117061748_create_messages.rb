class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :conversation
      t.references :user, null: false, foreign_key: {on_delete: :cascade}
      t.string :text

      t.timestamps
    end
  end
end
