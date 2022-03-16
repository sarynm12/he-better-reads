module API
  class ReviewsController < ApplicationController
    def index
      render json: Review.all
    end

    def show
      render json: Review.find(params[:id])
    end

    private

    def allowed_params
      params.permit(:book_id, :user_id, :rating, :description)
    end
  end
end