class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[ show ]
  before_action :not_if_banned

  # GET /conversations or /conversations.json
  def index
    @conversations = current_user.conversations
  end

  # GET /conversations/1 or /conversations/1.json
  def show
    unless @conversation.allowed? current_user
      redirect_to conversations_url
    end
  end

  # POST /conversations or /conversations.json
  def create
    target = User.find_by(id: params[:user_id])

    respond_to do |format|
      if target
        @conversation = Conversation.with_users(current_user, target).take || Conversation.new
        @conversation.users = [current_user, target]
        @conversation.save
        format.html { redirect_to conversation_url(@conversation), notice: "Conversation was successfully created." }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { redirect_to conversations_url }
        format.json { render json: "Target missing", status: :unprocessable_entity }
      end
    end
  end

  def new_message
    @conversation = Conversation.find(params[:id])
    @message = Message.new(user: current_user, conversation: @conversation, text: params[:text])

    respond_to do |format|
      if @message.save
        format.html { redirect_to conversation_url(@conversation), notice: "Message posted." }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { redirect_to conversations_url }
        format.json { render json: "Target missing", status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
end
