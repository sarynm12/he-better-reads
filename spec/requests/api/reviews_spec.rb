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

  describe 'POST to /' do
    context 'when successful' do
      let(:user) { create(:user) }

      let(:book) { create(:book) }

      let(:review) { create(:review) }
      let(:params) do
        {
          user_id: user.id,
          book_id: book.id,
          rating: 2,
          description: 'I had higher expectations for this book'
        }
      end
      
      it 'creates a review' do
        expect { post api_reviews_path, params: params }.to change { Review.count }
      end

      it 'returns the created review' do
        post api_reviews_path, params: params

        expect(response_hash).to include(params)
      end
    end

    context 'when description field is blank' do
      let(:user) { create(:user) }
      let(:book) { create(:book) }

      let(:params) do
        {
          rating: 3,
          description: '',
          user_id: user.id,
          book_id: book.id 
        }
      end

      it 'still creates a review' do
        expect { post api_reviews_path, params: params }.to change { Review.count }
      end

      it 'returns the created review without a description' do
        post api_reviews_path, params: params

        expect(response_hash).to include(params)
      end
    end

    context 'when unsuccessful' do
      let(:book) { create(:book) }

      let(:params) do
        {
          rating: 4,
          description: 'Best book ever',
          book_id: book.id,
          user_id: -1
        }
      end

      it 'returns an error if user is missing' do
        post api_reviews_path, params: params

        expect(response_hash).to eq(
          {
            errors: ['User must exist']
          }
        )
      end
    end

    context 'when unsuccessful' do
      let(:user) { create(:user) }

      let(:params) do
        {
          rating: 1,
          description: 'Worst book ever',
          user_id: user.id,
          book_id: -1
        }
      end

      it 'returns an error if book is missing' do
        post api_reviews_path, params: params

        expect(response_hash).to eq(
          {
            errors: ['Book must exist']
          }
        )
      end
    end

    context 'when unsuccessful' do
      let(:user) { create(:user) }
      let(:book) { create(:book) }

      let(:params) do
        {
          rating: 8,
          description: 'Love this book',
          user_id: user.id,
          book_id: book.id
        }
      end

      it 'returns an error if rating is greater than 5' do
        post api_reviews_path, params: params
        
        expect(response_hash).to eq(
          {
            errors: ['Rating must be less than or equal to 5']
          }
        )
      end
    end

    context 'when unsuccessful' do
      let(:user) { create(:user) }
      let(:book) { create(:book) }

      let(:params) do
        {
          rating: 0,
          description: 'Hate this book',
          user_id: user.id,
          book_id: book.id
        }
      end

      it 'returns an error if rating is less than 1' do
        post api_reviews_path, params: params
        
        expect(response_hash).to eq(
          {
            errors: ['Rating must be greater than or equal to 1']
          }
        )
      end
    end

    context 'when unsuccessful' do
      let(:user) { create(:user) }
      let(:book) { create(:book) }

      let(:params) do
        {
          rating: 2,
          description: 'Book is okay',
          user_id: user.id,
          book_id: book.id
        }
      end

      it 'only allows a user to submit one review per book' do
         expect { post api_reviews_path, params: params }.to change { Review.count }

         post api_reviews_path, params: params

         expect(response_hash).to eq(
           {
             errors: ['Book you\'ve already reviewed']
           }
         )
      end
    end
  end

  describe 'PUT to /:id' do
    let(:review) { create(:review) }

    context 'when successful' do
      let(:params) do
        {
          description: 'I read this book in 2 days. Amazing'
        }
      end

      it 'updates an existing review' do
        put api_review_path(review), params: params

        expect(review.reload.description).to eq(params[:description])
      end

      it 'returns the updated review' do
        put api_review_path(review), params: params

        expect(response_hash).to include(params)
      end
    end

    context 'when unsuccessful' do
      let(:params) do
        {
          rating: ''
        }
      end

      it 'returns an error' do
        put api_review_path(review), params: params

        expect(response_hash).to eq(
          {
            errors: ['Rating can\'t be blank', 'Rating is not a number']
          }
        )
      end
    end
  end
end