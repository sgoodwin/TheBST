require "test_helper"
require "helpers/login"

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  include LoginHelper

  setup do
    @conversation = conversations(:one)
    users(:admin).add_role :admin
  end

  test "should get index" do
    login users(:one)

    get conversations_url
    assert_response :success
  end

  test "should create conversation" do
    login users(:one)

    assert_difference("Conversation.count") do
      post conversations_url, params: { user_id: users(:another).id }
    end

    assert_redirected_to conversation_url(Conversation.last)
  end

  test "should not create conversation if one exists with same person" do
    login users(:one)

    assert_no_difference("Conversation.count") do
      post conversations_url, params: { user_id: users(:two).id }
    end

    assert_redirected_to conversation_url(conversations(:one))
  end

  test "should not create conversations if not logged in" do
    assert_no_difference("Conversation.count") do
      post conversations_url, params: { user_id: 666 }
    end

    assert_redirected_to root_url
  end

  test "should not create conversation without a valid target user" do
    login users(:one)

    assert_no_difference("Conversation.count") do
      post conversations_url, params: { user_id: 666 }
    end

    assert_redirected_to conversations_url
  end

  test "posting a new message" do
    login users(:one)

    assert_difference("Message.count") do
      post new_message_url(@conversation), params: { :text => "This is the message" }
    end
  end

  test "can't post a new message without text" do
    login users(:one)

    assert_no_difference("Message.count") do
      post new_message_url(@conversation)
    end
  end

  test "should show conversation" do
    login users(:one)

    get conversation_url(@conversation)
    assert_response :success
  end

  test "admins can see other peoples conversations" do
    login users(:admin)

    get conversation_url(@conversation)
    assert_response :success
  end

  test "should not show other conversations" do
    login users(:banned)

    get conversation_url(@conversation)
    assert_redirected_to conversations_url
  end
end
