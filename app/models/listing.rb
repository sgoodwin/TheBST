class Listing < ApplicationRecord
  validates :price, presence: true, comparison: { greater_than: 0 }
  validates :title, presence: true
  validates :info, presence: true
  validates :currency, presence: true
  validates :user_id, presence: true

  belongs_to :user
end
