class Item < ApplicationRecord
  belongs_to :sale
  belongs_to :product

  validates :price, :count, presence: true
  validates :product_id, uniqueness: { scope: :sale_id }
end
