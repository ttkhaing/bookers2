class UsersController < ApplicationController
  def new 
    @user = User.new
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user.params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :user_introduction)
  end
end
