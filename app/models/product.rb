class Product < ApplicationRecord
  belongs_to :merchant
  validates :description, presence: true
  validates :description, uniqueness: { scope: :merchant_id }
end
