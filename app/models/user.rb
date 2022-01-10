class User < ApplicationRecord
  rolify
  has_secure_password
  has_many :listings, -> { order('status ASC') }
  has_many :bans, -> { order('end_at DESC') }

  validates :name, presence: true
  validates :email, presence: true

  def banned?
    !bans.where('end_at > ?', Date.today).empty?
  end

  def ban!(end_at, reason)
    Ban.create!(user: self, end_at: end_at, reason: reason)
  end
end
