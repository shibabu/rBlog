class Admin::SessionsController < Admin::ApplicationController
  before_action :logged_in, only: :new
  layout 'admin/login'

  def new
  end

  def create
    @user=User.authenticate params[:email], params[:password]
    if @user
      session[:user_id]=@user.id
      redirect_to admin_posts_path, notice: 'Logged in successfully..'
    else
      flash.now.alert = 'Invalid email or password..'
      render 'new'
    end
  end

  def destroy
    session[:user_id]=nil

    redirect_to root_path, notice: 'Successfully logged out..'
  end
end
