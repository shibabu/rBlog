class PostsController < ApplicationController
  before_action :set_categories

  def index
    if params[:search]
      @posts=Post.search params[:search]
    else
      @posts=Post.all
    end
  end

  def show
    @post=Post.find params[:id]
    @category=@post.category
  end

  private
  def set_categories
    @categories=Category.all
  end
end
