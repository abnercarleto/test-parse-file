class Purchaser < ApplicationRecord
  has_many :sales

  validates :name, presence: true
  validates :name, uniqueness: true
end
