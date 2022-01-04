class Listing < ApplicationRecord
  enum status: { active: 'active', cancelled: 'cancelled', sold: 'sold' }

  validates :price, presence: true, comparison: { greater_than: 0 }
  validates :title, presence: true
  validates :info, presence: true
  validates :currency, presence: true
  validates :user_id, presence: true
  validates :status, presence: true

  belongs_to :user
end
