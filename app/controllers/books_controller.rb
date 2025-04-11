class BooksController < ApplicationController
  before_action :authenticate_user!
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
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = User.find(current_user.id)
  end

  def show 
    @books = Book.all
    @user = User.find(params[:id])
    @book = Book.find(params[:id])
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "Book has been Updated successfully."
      redirect_to books_path
    else
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
end
