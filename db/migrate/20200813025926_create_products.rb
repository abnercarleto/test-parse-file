class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :description, null: false
      t.references :merchant, null: false, foreign_key: true

      t.timestamps

      t.index %i(merchant_id description), unique: true
    end
  end
end
