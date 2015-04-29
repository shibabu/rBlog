class Admin::CategoriesController < Admin::ApplicationController
  before_action :search_path

  def new
    @category=Category.new
  end

  def create
    @category=Category.new category_params

    if @category.save
      flash[:notice]='Category successfully created..'

      redirect_to admin_categories_path
    else
      flash[:alert]="Couldn't create the category.."

      render :new
    end
  end

  def edit
    @category=Category.find params[:id]
  end

  def update
    @category=Category.find params[:id]

    if @category.update category_params
      flash[:notice]='Category successfully updated..'

      redirect_to admin_categories_path
    else
      flash[:alert]='Couldn\'t update the category..'

      render :edit
    end
  end

  def destroy
    @category=Category.find params[:id]

    if @category.delete
      flash[:notice]='Category successfully deleted..'

      redirect_to admin_categories_path
    else
      flash[:alert]="Coudn't delete the category.."
      redirect_to admin_categories_path
    end
  end

  def index
    if params[:search]
      @categories=Category.search(params[:search]).all.order('created_at DESC').paginate per_page: 5, page: params[:page]
    else
      @categories=Category.all.order('created_at DESC').paginate per_page: 5, page: params[:page]
    end
  end

  def show
  end


  private
  def category_params
    params.require(:category).permit(:name)
  end

  def search_path
    @spath=admin_categories_path
  end

end
