json.array!(@posts) do |post|
  json.extract! post, :id, :title, :body, :tag
  json.user_name User.find(post.user_id).name
  json.url post_url(post, format: :json)
end
