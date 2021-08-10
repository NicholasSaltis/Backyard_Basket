class Product < ApplicationRecord
  belongs_to :profile
  has_many_attached :pictures
end
