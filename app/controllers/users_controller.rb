class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.all.sort_by(&:rating).reverse
  end

  def show
    @user_posts = Post.where(user: @user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :avatar_url))
    if @user.save
      session[:user_id] = @user.id
      session[:counter] = 0
      flash[:success] = "Thank you for signing up!"
      redirect_to root_path
    else 
      flash[:alert] = "Something is wrong, try again!"
      redirect_to :back
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

end
