class Address < ApplicationRecord
  belongs_to :profile
  geocoded_by :address
  after_validation :geocode


  def address
    [house_number, street_name, suburb, state, country].compact.join(', ')
  end

  [:house_number, :street_name, :suburb, :postcode, :state, :country].each do |v|
    validates v, presence: true
  end
  validates :house_number, numericality: { in: 1..2000, only_integer: true }
  validates :state, length: { is: 3 }
  validates :country, length: { is: 2 }
  validates :postcode, numericality: { in: 1000..9999, only_integer: true }
  validates :street_name, format: { with: /[a-zA-Z\s]/ }
end
