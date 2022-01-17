class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :text, presence: true
  validates :user_id, presence: true
end
