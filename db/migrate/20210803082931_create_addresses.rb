class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer :house_number
      t.string :street_name
      t.string :suburb
      t.integer :postcode
      t.string :state
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
