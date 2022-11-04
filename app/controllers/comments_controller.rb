class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]
  def index
    @comments = @post.comments
  end


  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(params_comment)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Comment was created successfully."
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit ;
  end

  def update
    if @comment.update(params_comment)
      flash[:notice] = "Comment was updated successfully."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Comment was deleted successfully."
    redirect_to post_path(@post)
  end
  private

  def set_post
    @post = Post.find(params[:post_id])
  end
  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def params_comment
    params.require(:comment).permit(:content).merge(post_id: params[:post_id])
  end

end
