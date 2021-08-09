class AddCountryToAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :country, :string
  end
end
