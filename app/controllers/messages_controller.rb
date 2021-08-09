class MessagesController < ApplicationController
    
    
    def new_message
        puts "************************"
        @sender = current_user.profile
        @recipient = Profile.find(params[:profile_id])
        puts @sender
        @sender.send_message(@recipient, params[:topic], params[:body])
      end

end