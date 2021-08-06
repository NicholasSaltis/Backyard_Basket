class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.boolean :organic
      t.date :harvested_date
      t.date :expiry_date
      t.integer :stock
      t.float :price_per_unit
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
