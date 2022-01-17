class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.timestamps
    end

    create_table :conversations_users, id: false do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :conversation
    end
  end
end
