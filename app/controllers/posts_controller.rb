class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post_params, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.includes(:user, :types).order(comments_count: :desc).kept
    @hot_posts = Post.order(comments_count: :desc).limit(3).select { |post| post.comments_count >= 1 }
    respond_to do |format|
      format.html
      format.json { render json: @posts, each_serializer: PostSerializer }
    end
  end

  def short_url
    @post = Post.find_by(unique_string: params[:unique_string])
    redirect_to post_path(@post)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if Rails.env.development?
      @post.ip_address = Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
    else
      @post.ip_address = request.remote_ip
    end
    if @post.save
      flash[:notice] = "Disaster Information was created successfully."
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def show; end

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
    else
      @post.discard
      flash[:notice] = "Disaster Information was delete successfully."
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :address, :unique_string, type_ids: [])
  end

  def set_post_params
    @post = Post.find(params[:id])
  end
end
