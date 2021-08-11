class Profile < ApplicationRecord
  belongs_to :user
  has_one :address, dependent: :destroy
  has_many :products, dependent: :destroy
  accepts_nested_attributes_for :address
  has_many :recieved_reviews, class_name: 'Review', foreign_key: 'seller_id'
  has_many :posted_reviews, class_name: 'Review', foreign_key: 'reviewer_id'
  has_one_attached :profile_img

  acts_as_messageable :required => :body

  [:user_name, :first_name, :last_name].each do |v|
    validates v, presence: true
    validates v, length: { in: 2..75}
  end

end
