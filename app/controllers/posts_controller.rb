class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]

  # GET /posts
  # GET /posts.json
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    elsif params[:search]
      @posts = Post.search(params[:search])
    else
      @posts = Post.all.newest
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  def count
    @post = Post.find(params[:post_id])

  end

  def userallposts
    @user = User.find(current_user.id)
    @posts = @user.posts
  end

  def most_popular
    @posts = Post.order('rate DESC').limit(5)
  end

  def active_posts
    @posts = Post.order(:updated_at).last(3).reverse
  end

  def favorites
    @favorite = Favorite.where(user: current_user)
    @favorite_posts = []
    Post.all.each do |post|
      @favorite.all.each do |favorite|
        if favorite.post == post
          @favorite_posts.push post
        end
      end
    end
  end

  def add_to_favorite
    @post = Post.find(params[:post_id])
    Favorite.create(post: @post, user: current_user)
    redirect_to :back
  end

  def remove_from_favorite
    @post = Post.find(params[:post_id])
    Favorite.where(post: @post, user: current_user).first.destroy
    redirect_to :back
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    if current_user
      @post = Post.new(post_params)
      respond_to do |format|
        if @post.save
          flash[:success] = 'Post was successfully created.'
          format.html { redirect_to @post }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
       flash[:alert] = 'Sing up or Log in'
      redirect_to posts_path 
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if  current_user && current_user.id == @post.user_id
      respond_to do |format|
        if @post.update(post_params)
          flash[:success] = 'Post was successfully updated.'
          format.html { redirect_to @post }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:error] = 'Ви має право змінювати лише свої пости'
      redirect_to posts_path
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    alert = ""
    if current_user && current_user.id == @post.user_id
      @post.destroy
    #else
    #  alert = "Ви має право видаляти лише свої пости"
     # render json: {data: alert}
    end
  end

  def like
    if current_user && (@post.user_id != current_user.id) && not(@post.rater.include?(current_user.id))
      @post.update_attribute(:rater, @post.rater.push(current_user.id))
      @post.update_attribute(:rate, @post.rate + 1)
    else
      flash[:error] = 'you have to login or you can not rate own posts or can rate one time'
    end
    redirect_to :back
  end

  def unlike
    if current_user && (@post.user.id != current_user.id) && not(@post.rater.include?(current_user.id))
      @post.update_attribute(:rater, @post.rater.push(current_user.id))
      @post.update_attribute(:rate, @post.rate - 1)
    else
      flash[:error] = 'you have to login or you can not rate own posts or can rate one time'
    end
    redirect_to :back
  end

 # def rates
  #  post = Post.find(params[:post_id])
  #  if current_user && (post.user.id != current_user.id) && not(post.rater.include?(current_user.id))
  #    post.update_attribute(:rater, post.rater.push(current_user.id))
  #    post.update_attribute(:rate, post.rate + params[:rating].to_i)
      #post.rate.increment
      #post.save
   # end
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :tag_list, :image_url).merge(user_id: current_user.id)
    end
end
