class Profile < ApplicationRecord
  belongs_to :user
  has_one :address
  has_many :products, dependent: :destroy
  accepts_nested_attributes_for :address
end
