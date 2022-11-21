class Admin::PostsController < AdminController
  def index
    @posts = Post.includes(:user, :types, :region, :province, :city_municipality, :barangay).order(comments_count: :desc).kept
    @hot_posts = Post.order(comments_count: :desc).limit(3).select { |post| post.comments_count >= 1 }
    render 'posts/index'
  end
end


