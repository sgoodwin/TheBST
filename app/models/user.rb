class User < ApplicationRecord
  has_secure_password
  has_many :listings, -> { order('status ASC') }
end
