class Conversation < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :messages, -> { order('created_at ASC') }

  def allowed?(user)
    user.has_role?(:admin) || user_ids.include?(user.id)
  end

  def self.with_users(usera, userb)
    usera.conversations.joins(:users).where('users.id' => userb)
  end
end
