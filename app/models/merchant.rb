class Merchant < ApplicationRecord
  validates :name, :address, presence: true
  validates :address, uniqueness: { scope: :name }
end
