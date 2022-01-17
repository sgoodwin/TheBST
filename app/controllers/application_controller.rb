class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    return nil unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def not_if_banned
    if !logged_in? 
      redirect_to root_url
    elsif current_user && current_user.banned?
      redirect_to root_url, alert: "You are banned until #{current_user.bans.last.end_at}"
    end
  end
end
