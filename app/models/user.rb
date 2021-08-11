class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # declaration for devise modules, established by running rails g devise user. 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # one to one relationship with profile. if user is destroyed so is profile. 
  has_one :profile, dependent: :destroy

end
