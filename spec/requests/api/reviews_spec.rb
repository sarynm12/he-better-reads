RSpec.describe '/api/reviews' do
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  describe 'GET to /' do
    it 'returns all reviews' do
      review = create(:review)

      get api_reviews_path

      expect(response_hash).to eq(
        [
          {
            book_id: review.book_id,
            user_id: review.user_id,
            created_at: review.created_at.iso8601(3),
            rating: review.rating,
            id: review.id,
            description: review.description,
            updated_at: review.updated_at.iso8601(3)
          }
        ]
      )
    end
  end
end