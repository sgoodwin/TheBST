class AddUserRelations < ActiveRecord::Migration[7.0]
  def up
    change_table :listings do |t|
      t.references :user
    end
  end

  def down
    remove_column :listings, :user_id
  end
end
