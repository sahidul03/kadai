class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :access_token

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def access_token
    if session[current_user.id]
      @access_token = session[current_user.id]
    else
      @access_token = nil
    end
  end

  def check_authentication
    unless session[:user_id]
      redirect_to login_path
    end
  end
end
