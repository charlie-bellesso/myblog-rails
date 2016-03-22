class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :authorize, :store_location, :redirect_back, :flash_msg

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    store_location
    redirect_to '/login' unless current_user
  end

  def store_location
    session[:return_to] = request.url
  end

  def redirect_back(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def flash_msg(msg, type)
    flash[:notice] = msg
    flash[:type] = type
    flash.discard(:notice)
    flash.discard(:type)
  end
end
