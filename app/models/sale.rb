class Sale < ApplicationRecord
  belongs_to :purchaser
  belongs_to :sale_import
  has_many :items
end
