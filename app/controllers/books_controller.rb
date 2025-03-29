class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:edit, :update, :destroy]
  def new
    @book = current_user.books.new
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to books_path
    else
      render :new
    end
  end

  def index
    @user = current_user
    @books = current_user.books
  end

  def edit
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
