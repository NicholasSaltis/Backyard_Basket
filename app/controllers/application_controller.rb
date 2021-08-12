class ApplicationController < ActionController::Base
    
    # before action to pass profile id to navbar partial so that it can link to the correct profile.
    before_action :get_profile_id
    # modification to existing after_sign_in_path_for method to redirect the user to create a profile after registering with devise.
    def after_sign_in_path_for(profile)
        if current_user.profile
          root_path
        else
          new_profile_path
        end
    end
    # custom method to prevent error with navbar partial not having access to profile id for profile_path whilst user is still signing up to the app.
    def get_profile_id
        if user_signed_in? && current_user.profile
        @profile_id = current_user.profile.id
        end
    end
end
