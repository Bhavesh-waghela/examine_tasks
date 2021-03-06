class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.find_by_id(session[:current_user_id])
  end
end
