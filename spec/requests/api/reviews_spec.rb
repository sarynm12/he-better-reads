RSpec.describe '/api/reviews' do
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  describe 'GET to /' do
    it 'returns all reviews' do
      review = create_list(:review, 2)

      get api_reviews_path

      expect(Review.count).to eq(2)
      expect(response_hash).to eq(
        [
          {
            book_id: review[0].book_id,
            user_id: review[0].user_id,
            created_at: review[0].created_at.iso8601(3),
            rating: review[0].rating,
            id: review[0].id,
            description: review[0].description,
            updated_at: review[0].updated_at.iso8601(3)
          },
          {
            book_id: review[1].book_id,
            user_id: review[1].user_id,
            created_at: review[1].created_at.iso8601(3),
            rating: review[1].rating,
            id: review[1].id,
            description: review[1].description,
            updated_at: review[1].updated_at.iso8601(3)
          }
        ]
      )
    end
  end

  describe 'GET to /:id' do
    context 'when found' do
      it 'returns a book review' do
        review = create(:review)

        get api_review_path(review)

        expect(Review.count).to eq(1)
        expect(response_hash).to eq(
          {
            book_id: review.book_id,
            user_id: review.user_id,
            created_at: review.created_at.iso8601(3),
            rating: review.rating,
            id: review.id,
            description: review.description,
            updated_at: review.updated_at.iso8601(3)
          }
        )
      end
    end

    context 'when not found' do
      it 'returns not_found' do
        get api_review_path(-1)

        expect(response).to be_not_found
      end
    end
  end
end