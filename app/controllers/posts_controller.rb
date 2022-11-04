class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post_params, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.includes(:user, :types).order(comments_count: :desc).kept
    @hot_posts = Post.order(comments_count: :desc).limit(3).select{ |post| post.comments_count >= 1 }

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Disaster Information was created successfully."
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @post.update(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Disaster Information was update successfully."
      redirect_to posts_path
    end
  end

  def destroy
    if @post.comments_count >= 1
      flash[:notice] = "This information has comment you can't delete."
    else @post.discard
    flash[:notice] = "Disaster Information was delete successfully."
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :address, type_ids: [])
  end

  def set_post_params
    @post = Post.find(params[:id])
  end
end
