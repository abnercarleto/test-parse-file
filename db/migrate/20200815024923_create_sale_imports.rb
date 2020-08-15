class CreateSaleImports < ActiveRecord::Migration[6.0]
  def change
    create_table :sale_imports do |t|

      t.timestamps
    end
  end
end
