require "test_helper"
require "helpers/login"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include LoginHelper

  setup do
    @user = users(:one)
    users(:admin).add_role :admin
    users(:banned).ban!(1.week.from_now, "They trolled")
  end

  test "should allow login" do
    post login_path, params: { email: "someone.awesome@gmail.com", password: "password" }
    assert_redirected_to  root_url, status: :success
  end

  test "should not allow login when it's wrong" do
    post login_path, params: { email: "someone.awesome@gmail.com", password: "wrongpassword" }
    assert_redirected_to root_url, notice: "Incorrect login information" 
  end

  test "should logout" do
    login @user
    get logout_url
    assert_redirected_to  root_url, status: :success
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

  test "should not create invalid user" do
    assert_no_difference("User.count") do
      post users_url, params: { user: { email: "new.person@gmail.com", name: "New Person", password: "password", password_confirmation: "notmatching" } }
    end

    assert_response :unprocessable_entity
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

  test "should not update invalid user" do
    login @user
    patch user_url(@user), params: { user: { email: @user.email, name: nil } }
    assert_response :unprocessable_entity
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

  test "admins should ban user" do
    login users(:admin)
    assert_difference("Ban.count") do
      post ban_url(@user), params: { end_at: 1.week.from_now, reason: "User was trolling" }
    end

    assert @user.banned?
  end

  test "non-admins should not ban user" do
    login users(:one)
    assert_no_difference("Ban.count") do
      post ban_url(@user), params: { end_at: 1.week.from_now, reason: "User was trolling" }
    end

    assert !@user.banned?
  end
end
