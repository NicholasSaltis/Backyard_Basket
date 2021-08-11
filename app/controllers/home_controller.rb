class HomeController < ApplicationController
  def index
  end
  # browse link from navbar shows all or just nearby users depending if user is signin or not.
  def browse
    # if user is signed in the should have a geocode address which is queried here and then nearbys searches via API for other addresses within a 5 mile radius. 
    # includes is passed 2 values to preload profiles and profile images. 
    if user_signed_in?
      @nearby_profiles = current_user.profile.address.nearbys(5).includes(:profile, profile: :profile_img_attachment)
    else
    # if user is not signed in return all profiles by default. Placeholder until a search function can be implemented. 
      @profiles = Profile.all.includes(:address, :profile_img_attachment)
    end
    
  end
end
