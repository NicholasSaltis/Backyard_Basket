class Product < ApplicationRecord
  #one to many relation ship with profile. 
  belongs_to :profile
  # polymorphous relationship with active storage. call pictures on @product to query active record and return array of pictures
  has_many_attached :pictures

  # Validates presence of non optional information critical to products. 
  [:name, :description, :harvested_date, :expiry_date, :stock].each do |v|
    validates v, presence: true
  end
  # prevents excessively long product titles
  validates :name, length: { in: 3..100 }
  # prevents excessively long product details
  validates :description, length: { maximum: 1000 }
  # ensures stock is an integer, is greater than zero and does not exceed 1000 which is an unrealistic amount of stock for home grown produce.
  validates :stock, numericality: { greater_than: 0, less_than_or_equal_to: 1000, only_integer: true } 
  # same validation purpose as stock validations.
  validates :price_per_unit, numericality: { greater_than: 0, less_than_or_equal_to: 1000, only_integer: true}
  # uses https://github.com/adzap/validates_timeliness gem to allow for simplified validation of date-time values. Harvested date cannot be beyond the current date
  validates_date :harvested_date, on_or_before: :today, before_message: "Cannot be later than Today's Date."
  # expiry date must be from tomorrow's date onwards.
  validates_date :expiry_date, after: :today, before_message: "Must be from tomorrow's date onwards"
end
