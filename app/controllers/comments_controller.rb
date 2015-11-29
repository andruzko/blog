class CommentsController < ApplicationController
    before_action :set_post, only: [:create, :destroy]

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to post_path(@post)
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if current_user && current_user.id == @comment.user_id
      @comment.destroy
    end
      redirect_to post_path(@post)
  end

  private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
