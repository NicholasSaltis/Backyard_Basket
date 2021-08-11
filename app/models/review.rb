class Review < ApplicationRecord
  # yet to be implemented review functionality
  belongs_to :reviewer_id, class_name: 'Profile'
  belongs_to :seller_id, class_name: 'Profile'
end
