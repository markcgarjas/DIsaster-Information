class Admin::PostsController < AdminController
  def index
    @posts = Post.includes(:user, :types, :region, :province, :city_municipality, :barangay).order(comments_count: :desc).kept
    render 'posts/index'
  end
end


