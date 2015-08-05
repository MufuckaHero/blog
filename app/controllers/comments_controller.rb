class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save

    redirect_to @post
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if current_user.id == @comment.user_id
      @comment.destroy
      redirect_to post_path(@post)
    end
  end
  
  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
