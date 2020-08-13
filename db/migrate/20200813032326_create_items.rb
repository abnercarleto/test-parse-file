class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :sale, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.decimal :price, null: false, precision: 8, scale: 2
      t.integer :count, null: false, default: 1

      t.timestamps

      t.index %i(sale_id product_id), unique: true
    end
  end
end
