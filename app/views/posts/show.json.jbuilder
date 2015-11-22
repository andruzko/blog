json.extract! @post, :id, :title, :body, :tag, :created_at
json.user_name User.find(@post.user_id).name