module API
  module Books
    class ReviewsController < ApplicationController
      def index
        book = Book.find(params[:book_id])
        render json: book.reviews
      end
    end
  end
end