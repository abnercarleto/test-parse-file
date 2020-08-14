class Sale < ApplicationRecord
  belongs_to :purchaser
  has_many :items
end
