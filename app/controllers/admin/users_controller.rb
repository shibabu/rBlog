class Admin::UsersController < Admin::ApplicationController
  before_action :require_user
  before_action :search_path

  def new
    @user=User.new
  end

  def create
    @user=User.new user_params

    if @user.save
      flash[:notice]='User successfully created..'

      redirect_to admin_users_path
    else
      flash[:alert]="Couldn't create the user.."

      render :new
    end
  end

  def edit
    @user=User.find params[:id]
  end

  def update
    @user=User.find params[:id]

    if @user.update user_params
      flash[:notice]='User successfully updated..'

      redirect_to admin_users_path
    else
      flash[:alert]='Couldn\'t update the user..'

      render :edit
    end
  end

  def destroy
    @user=User.find params[:id]

    if @user.delete
      flash[:notice]='User successfully deleted..'

      redirect_to admin_users_path
    else
      flash[:alert]="Coudn't delete the user.."
      redirect_to admin_users_path
    end
  end

  def index
    if params[:search]
      @users=User.search(params[:search]).all.order('created_at DESC').paginate per_page: 5, page: params[:page]
    else
      @users=User.all.order('created_at DESC').paginate per_page: 5, page: params[:page]
    end
  end

  def show
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def search_path
    @spath=admin_users_path
  end
end
