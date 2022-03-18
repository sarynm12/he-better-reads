module API
  module Reviews
    class SearchController < ApplicationController
      def index
        reviews = Review.sorted(params[:sort])
        render json: reviews
      end

      private

      def search_params
        params.permit(:rating, :description, :user_id, :book_id)
      end
    end
  end
end