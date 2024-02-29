class CreateCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :currency
      t.string :code
      t.integer :tax_type, default: 0
      t.float :tax_value, default: 0.0
      t.string :service_provider_name
      t.string :email
      t.text :address
      t.string :phone_number
      t.string :invoice_prefix, default: 'WR'
      t.integer :status, default: 0
      t.text :policy_description

      t.timestamps
    end
  end
end
