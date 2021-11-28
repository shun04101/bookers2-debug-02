class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comment.user_id = current_user.id
    if @book_comment.save
      render :book_comments # render先にjsファイルを指定
    else
      render :error # render先にjsファイルを指定
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    book_comment = @book.book_comments.find(params[:id])
    book_comment.destroy
    render :book_comments # render先にjsファイルを指定
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end