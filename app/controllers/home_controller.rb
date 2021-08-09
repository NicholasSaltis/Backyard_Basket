class HomeController < ApplicationController
  def index
  end

  def browse
    @profiles = Profile.all
    @nearby_profiles = current_user.profile.address.nearbys(5)
  end
end
