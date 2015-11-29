class UsersController < ApplicationController
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
      flash[:alert] = "Something is wrong!"
      redirect_to :back
    end
  end
end
