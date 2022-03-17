RSpec.describe '/api/books/reviews' do
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  describe 'GET to /:id/reviews' do
    it 'returns all reviews for a given book' do
      book = create(:book)
      user1 = create(:user)
      user2 = create(:user)
      review1 = create(:review, user_id: user1.id, book_id: book.id)
      review2 = create(:review, user_id: user2.id, book_id: book.id)

      get api_book_reviews_path(book)

      expect(book.reviews.count).to eq(2)
      expect(response_hash).to eq(
        [
          {
            id: review1.id,
            rating: review1.rating,
            description: review1.description,
            user_id: review1.user_id,
            book_id: book.id,
            created_at: review1.created_at.iso8601(3),
            updated_at: review1.updated_at.iso8601(3)
          },
          {
            id: review2.id,
            rating: review2.rating,
            description: review2.description,
            user_id: review2.user_id,
            book_id: book.id,
            created_at: review2.created_at.iso8601(3),
            updated_at: review2.updated_at.iso8601(3)
          }
        ]
      )
    end

    it 'alerts the user if a book does not have any reviews' do
      book = create(:book)

      get api_book_reviews_path(book)

      expect(response_hash).to eq(
        {
          message: 'This book has no reviews'
        }
      )
    end
  end
end