class Coin < ApplicationRecord
  validates :description, presence: true
  belongs_to :mining_type #, optional: true
end
