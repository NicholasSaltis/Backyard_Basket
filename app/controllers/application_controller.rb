class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :get_profile_id
    def after_sign_in_path_for(profile)
        if current_user.profile
          root_path
        else
          new_profile_path
        end
    end

    def get_profile_id
        if user_signed_in? && current_user.profile
        @profile_id = current_user.profile.id
        puts @profile_id
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        end
    end
end
