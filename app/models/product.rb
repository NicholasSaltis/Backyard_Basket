class Product < ApplicationRecord
  belongs_to :profile
  has_many_attached :pictures

  [:name, :description, :harvested_date, :expiry_date, :stock].each do |v|
    validates v, presence: true
  end
  validates :name, length: { in: 3..100 }
  validates :description, length: { maximum: 1000 }
  validates :stock, numericality: { greater_than: 0, less_than_or_equal_to: 1000, only_integer: true } 
  validates :price_per_unit, numericality: { greater_than: 0, less_than_or_equal_to: 1000, only_integer: true}
  validates_date :harvested_date, on_or_before: :today, before_message: "Cannot be later than Today's Date."
  validates_date :expiry_date, after: :today, before_message: "Must be from tomorrow's date onwards"
end
