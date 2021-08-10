class MessagesController < ApplicationController
    
    
    def new_message
        puts "************************"
        @sender = current_user.profile
        @recipient = Profile.find(params[:profile_id])
        @sender.send_message(@recipient, {body: params[:body], topic: params[:topic]})
        if params[:response_type] == "reply"
            redirect_to messages_path
        end
    end

    def conversation

    end

    def index
        @messages = current_user.profile.received_messages
    end

    def outbox
        @messages = current_user.sent_messages
    end

    def show
        @message = current_user.profile.received_messages.find(params[:id])
    end

    def destroy
        @message = current_user.messages.find(params[:id])
        if @message.destroy
            flash[:notice] = "All ok"
        else
            flash[:error] = "Fail"
        end
    end

    def new
        @message = ActsAsMessageable::Message.new
    end

    def create
        @to = User.find_by_email(params[:message][:to])
        current_user.send_message(@to, params[:message][:topic], params[:message][:body])
    end

end