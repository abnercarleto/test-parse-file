class AddSaleImportReferencesToSale < ActiveRecord::Migration[6.0]
  def change
    add_reference :sales, :sale_import, foreign_key: true
  end
end
