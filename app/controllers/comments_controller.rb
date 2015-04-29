class CommentsController < ApplicationController

  def create
    @post=Post.find params[:post_id]
    @comment=@post.comments.new comment_params

    if @comment.save
      flash[:notice]='Comment successfully added..'

      redirect_to post_path(@post)
    else
      flash[:alert]='Could not save comment..'

      redirect_to post_path(@post)
    end
  end

  private
  def comment_params
  params.require(:comment).permit :name, :email, :body, :post_id
  end
end
