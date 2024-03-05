class CreateItemWarranties < ActiveRecord::Migration[7.0]
  def change
    create_table :item_warranties do |t|
      t.float :warranty_price_percent, default: 0.0
      t.boolean :active, default: true
      t.float :discount_percent, default: 0.0
      t.datetime :discount_start_date
      t.datetime :discount_end_date
      t.references :item, null: false, index: true
      t.references :warranty, null: false, index: true

      t.timestamps
    end
  end
end
