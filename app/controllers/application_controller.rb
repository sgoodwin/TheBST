class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    User.where(id: session[:user_id]).first
  end

  def logged_in?
    !current_user.nil?
  end
end
