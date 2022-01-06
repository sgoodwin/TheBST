module LoginHelper
  def login(user)
    post login_path, params: { email: user.email, password: "password" }
    assert_redirected_to root_url
    assert_nil flash[:notice]
  end
end
