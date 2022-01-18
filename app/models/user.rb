class User < ApplicationRecord
  rolify
  has_secure_password
  has_many :listings, -> { order('status ASC') }
  has_many :bans, -> { order('end_at DESC') }
  has_many :messages
  has_and_belongs_to_many :conversations
  belongs_to :region

  validates :name, presence: true
  validates :email, presence: true

  def admin?
    has_role? :admin
  end

  def banned?
    !bans.where('end_at > ?', Date.today).empty?
  end

  def ban!(end_at, reason)
    Ban.create!(user: self, end_at: end_at, reason: reason)
  end
end
