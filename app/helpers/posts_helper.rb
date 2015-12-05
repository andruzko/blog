module PostsHelper

  def favorited?(post)
    Favorite.where(post: post, user: current_user).present?
  end
  
end
