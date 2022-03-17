module API
  class ReviewsController < ApplicationController
    def index
      render json: Review.all
    end

    def show
      render json: Review.find(params[:id])
    end

    def create
      review = Review.new(allowed_params)

      if review.save
        render json: review
      else
        render json: { errors: review.errors.full_messages }
      end
    end

    def update
      review = Review.find(params[:id])

      if review.update(allowed_params)
        render json: review
      else
        render json: { errors: review.errors.full_messages }
      end
    end

    private

    def allowed_params
      params.permit(:book_id, :user_id, :rating, :description)
    end
  end
end