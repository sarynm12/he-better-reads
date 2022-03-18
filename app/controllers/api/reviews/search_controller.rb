module API
  module Reviews
    class SearchController < ApplicationController
      def index
        if params.keys.first == "descriptive"
          reviews = Review.descriptive_ratings
        elsif params.keys.first == "sort"
          reviews = Review.sorted(params[:sort])
        end
        render json: reviews
      end

      private

      def search_params
        params.permit(:rating, :description, :user_id, :book_id)
      end
    end
  end
end