class SaleImport < ApplicationRecord
  has_many :sales
  has_many :items, through: :sales

  def total_gross
    items.sum(&:price)
  end
end
