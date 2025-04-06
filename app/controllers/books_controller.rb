class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:edit, :update, :destroy]
  def new
    @book = current_user.books.new
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to book_path
    else
      render :new
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
  end

  def show 
    @books = Book.all
    @user = current_user
    @book = Book.find(params[:id])
  end

  def update
    if @book.update(book_params)
      redirect_to books_path
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, alert: "The book has been deleted!"
  end


  private

  def set_book
    @book = current_user.books.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :body )
  end
end
