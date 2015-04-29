class Admin::PostsController < Admin::ApplicationController
  before_action :search_path

  def new
    @post=Post.new
  end

  def create
    @post=Post.new post_params
    #binding.pry

    if @post.save
      flash[:notice]='post successfully created..'

      redirect_to admin_posts_path
    else
      flash[:alert]="Couldn't create the post.."

      render :new
    end
  end

  def edit
    @post=Post.find params[:id]
  end

  def update
    @post=Post.find params[:id]

    if @post.update post_params
      flash[:notice]='post successfully updated..'

      redirect_to admin_posts_path
    else
      flash[:alert]='Couldn\'t update the post..'

      render :edit
    end
  end

  def destroy
    @post=Post.find params[:id]

    if @post.delete
      flash[:notice]='post successfully deleted..'

      redirect_to admin_posts_path
    else
      flash[:alert]="Coudn't delete the post.."
      redirect_to admin_posts_path
    end
  end

  def index
    if params[:search]
      @posts=Post.search(params[:search]).all.order('created_at DESC').paginate per_page: 5, page: params[:page]
    else
      @posts=Post.all.order('created_at DESC').paginate per_page: 5, page: params[:page]
    end
  end

  def show
  end


  private
  def post_params
    params.require(:post).permit(:title, :category_id, :user_id, :tags, :image, :body)
  end

  def search_path
    @spath=admin_posts_path
  end
end
