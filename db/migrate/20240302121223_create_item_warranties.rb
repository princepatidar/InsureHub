class CreateItemWarranties < ActiveRecord::Migration[7.0]
  def change
    create_table :item_warranties do |t|
      t.float :warranty_price_percent, default: 0.0
      t.float :discount_percent, default: 0.0
      t.date :discount_start_date
      t.date :discount_end_date
      t.references :item, null: false, index: true
      t.references :warranty, null: false, index: true

      t.timestamps
    end
  end
end
