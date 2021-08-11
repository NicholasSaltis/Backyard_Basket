class HomeController < ApplicationController
  def index
  end

  def browse

    if user_signed_in?
      @nearby_profiles = current_user.profile.address.nearbys(5).includes(:profile)
    else
      @profiles = Profile.all.includes(:address)
    end
    
    
  end
end
