class Profile < ApplicationRecord
  belongs_to :user
  has_one :address
  has_many :products
  accepts_nested_attributes_for :address
end
