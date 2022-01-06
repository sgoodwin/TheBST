require "test_helper"
require "helpers/login"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include LoginHelper

  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { email: "new.person@gmail.com", name: "New Person", password: "password", password_confirmation: "password" } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    login @user
    patch user_url(@user), params: { user: { email: @user.email, name: @user.name } }
    assert_redirected_to user_url(@user)
  end

  test "should not allow destroying other users" do
    login @user
    assert_no_difference("User.count") do
      delete user_url(users(:two))
    end

  end

  test "should destroy user" do
    login @user
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
