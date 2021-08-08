class HomeController < ApplicationController
  def index
  end

  def browse
    @profiles = Profile.all
  end
end
