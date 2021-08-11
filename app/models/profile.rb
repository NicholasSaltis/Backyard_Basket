class Profile < ApplicationRecord
  # one to one relationship with user model. create profile form is automatically proceeded to after user registration.
  belongs_to :user
  # has one address which can be deleted with profile.
  has_one :address, dependent: :destroy
  # one to many relation ship with products. a profile can create multiple products. 
  has_many :products, dependent: :destroy
  # declaration for profile to also create address record via nested form. 
  accepts_nested_attributes_for :address
  # yet to be implemented reviews functionality
  has_many :recieved_reviews, class_name: 'Review', foreign_key: 'seller_id'
  has_many :posted_reviews, class_name: 'Review', foreign_key: 'reviewer_id'
  # has one polymorphic relation ship with active record. Query profile_img on profile object to return active record image. 
  has_one_attached :profile_img
  # declaration for acts_as_messageable gem. includes simple validation to ensure body parameter is not null.
  acts_as_messageable :required => :body

  # validates presence of each attribute so they cannot be null
  [:user_name, :first_name, :last_name].each do |v|
    validates v, presence: true
    validates v, length: { in: 2..75}
  end

end
