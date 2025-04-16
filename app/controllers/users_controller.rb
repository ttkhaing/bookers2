class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def new 
    @user = User.new
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
    
  end

  def edit
    @user = User.find(current_user.id)
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
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
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      flash[:alert] = "User update failed."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
