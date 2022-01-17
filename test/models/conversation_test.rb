require "test_helper"

class ConversationTest < ActiveSupport::TestCase
  test "finding an existing conversation" do
    conversation = Conversation.with_users(users(:one), users(:two))

    assert_not_nil conversation
  end

  test "won't find a conversation that doesn't exist" do
    conversation = Conversation.with_users(users(:one), users(:banned)).take

    assert_nil conversation
  end
end
