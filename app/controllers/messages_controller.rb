class MessagesController < ApplicationController
    # controller for acts_as_messageable and user messaging functionality. not created via scaffold 
    # before action to sanitize unwanted parameters only for the new_message method which at the moment serves as the create method
    before_action :message_params, only: %i[ new_message ]
    # takes sanitized parameters and uses them to create a new message using acts_as_messageable.
    def new_message
        # current user sends the message via their profile
        @sender = current_user.profile
        #recipient is found via profile id parameter which is passed from the view via a message show page or on the profile's pantry contact form.
        @recipient = Profile.find(params[:message][:profile_id])
        # method from acts_as_messageable that creates a new message record using the passed parameters. 
        @sender.send_message(@recipient, {body: params[:message][:body], topic: params[:message][:topic]})
        # conditional to redirect user back to messages index page after replying to a message received in their inbox. 
        if params[:message][:response_type] == "reply"
            redirect_to messages_path
        end
    end
    # yet to be implemented for advanced messaging functionality. 
    def conversation

    end
    # passes current user's received messages to messages/index page, preloads the message's sender's profile for effecient querying in the view.
    def index
        @messages = current_user.profile.received_messages.preload(:sent_messageable)
    end
    # yet to be implemented in view
    def outbox
        @messages = current_user.sent_messages
    end
    # passes individual message to message/show. receives params from button on messages index page. 
    def show
        @message = current_user.profile.received_messages.find(params[:id])
    end
    # yet to be implemented in the app. 
    def destroy
        @message = current_user.messages.find(params[:id])
        if @message.destroy
            flash[:notice] = "All ok"
        else
            flash[:error] = "Fail"
        end
    end
    # alternative message creation path yet to be implemented. 
    def new
        @message = ActsAsMessageable::Message.new
    end
    # alternative message creation path yet to be implemented. 
    def create
        @to = User.find_by_email(params[:message][:to])
        current_user.send_message(@to, params[:message][:topic], params[:message][:body])
    end

    private
    # private method to be called before new_message to sanitize passed params. response type used for redirecting user. profile_id for sending message to right user and topic and body for message content
    def message_params
        params.require(:message).permit(:topic, :body, :profile_id, :response_type)
    end
end