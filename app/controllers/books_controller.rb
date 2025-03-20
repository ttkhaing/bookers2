class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.save
    redirect_to '/homes'
  end

  def index
  end

  def edit
  end
  
  def show
  end

  def update
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
