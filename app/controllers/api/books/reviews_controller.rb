module API
  module Books
    class ReviewsController < ApplicationController
      def index
        book = Book.find(params[:book_id])
        if book.reviews.empty?
          render json: { message: 'This book has no reviews' }
        else
          render json: book.reviews
        end
      end
    end
  end
end