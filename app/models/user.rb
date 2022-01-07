class User < ApplicationRecord
  has_secure_password
  has_many :listings, -> { order('status ASC') }

  validates :name, presence: true
  validates :email, presence: true
end
