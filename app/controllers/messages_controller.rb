class MessagesController < ApplicationController
    before_action :message_params, only: %i[ new_message ]
    
    def new_message
        puts "************************"
        @sender = current_user.profile
        @recipient = Profile.find(params[:message][:profile_id])
        @sender.send_message(@recipient, {body: params[:message][:body], topic: params[:message][:topic]})
        if params[:message][:response_type] == "reply"
            redirect_to messages_path
        end
    end

    def conversation

    end

    def index
        @messages = current_user.profile.received_messages.preload(:sent_messageable)
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

    private

    def message_params
        params.require(:message).permit(:topic, :body, :profile_id, :response_type)
    end
end