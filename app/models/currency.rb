class Currency < ApplicationRecord
  validates :name, uniqueness: true
end
