class Address < ApplicationRecord
  belongs_to :profile
  geocoded_by :address
  after_validation :geocode


  def address
    [house_number, street_name, suburb, state, country].compact.join(', ')
  end
  
end
