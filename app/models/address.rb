class Address < ApplicationRecord
  # has_one assosciation with profile model. created via nested form in profile _form partial
  belongs_to :profile
  # targets this model to be targeted by geocoder gem. requires model to have latitude and longitude attributes.
  geocoded_by :address
  # hook that runs after the address entry is successfully validated. relies on the address method below to concatenate the address attributes into a format that is readable by one of the 40 map APIs that geocoder uses. Returns float latitude and longitude coordinates that are added to the address table entry.
  after_validation :geocode

# method used by geocoder to format address attributes for use in geolocation API
  def address
    [house_number, street_name, suburb, state, country].compact.join(', ')
  end
# validates presence of all address attributes as they are all important for running through geocoder api.
  [:house_number, :street_name, :suburb, :postcode, :state, :country].each do |v|
    validates v, presence: true
  end
  # ensures it is an integer and must be between 1 and 2000. the chances of a house number being over 2000 is very unlikely.
  validates :house_number, numericality: { in: 1..2000, only_integer: true }
  # Ensures that state entry is usuable 3 letter abbreviation for state names eg NSW, QLD
  validates :state, length: { is: 3 }
  # works with contry select gem to ensure input is 2 letter ISO 3166-1 alpha-2 code
  validates :country, length: { is: 2 }
  # constrains integer input to 4 digit number.
  validates :postcode, numericality: { in: 1000..9999, only_integer: true }
  # Regex for letters and spaces. 
  validates :street_name, format: { with: /[a-zA-Z\s]/ }
end
