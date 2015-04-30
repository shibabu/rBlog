class Admin::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'admin/application'

  helper_method :current_user

  private
  def current_user
    @current_user||=User.find session[:user_id] if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:alert]='This action requires authentication..'

      redirect_to admin_login_path
    end
  end

  def logged_in
    if logged_in?
      redirect_to admin_posts_path, notice: 'Already logged in..'
    end
  end
end
