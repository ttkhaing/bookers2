class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @book = current_user.books.new
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def index
    if params[:id].present?
      @user = User.find(params[:id])
      @books = @user.books
    else
      @user = current_user
      @books = Book.all
    end
    @book = Book.new
    @users = User.all
  end

  def show 
    @books = Book.all
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "Book has been Updated successfully."
      redirect_to book_path
    else
      flash[:alert] = "Book update failed."
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, alert: "The book has been deleted!"
  end


  private

  def book_params
    params.require(:book).permit(:title, :body )
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
end
