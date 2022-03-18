RSpec.describe '/api/reviews/search' do
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  describe 'GET to /reviews/search' do
    it 'can return a list of reviews ordered by descended rating' do
      review1 = create(:review, rating: 1)
      review2 = create(:review, rating: 5)
      review3 = create(:review, rating: 4)
      review4 = create(:review, rating: 2)

      get "/api/reviews/search?sort=DESC"
      
      expect(response_hash[0][:rating]).to eq(review2.rating)
      expect(response_hash[1][:rating]).to eq(review3.rating)
      expect(response_hash[2][:rating]).to eq(review4.rating)
      expect(response_hash[3][:rating]).to eq(review1.rating)
    end

    it 'can return a list of reviews ordered by ascended rating' do
      review1 = create(:review, rating: 1)
      review2 = create(:review, rating: 5)
      review3 = create(:review, rating: 4)
      review4 = create(:review, rating: 2)

      get "/api/reviews/search?sort=ASC"
      
      expect(response_hash[0][:rating]).to eq(review1.rating)
      expect(response_hash[1][:rating]).to eq(review4.rating)
      expect(response_hash[2][:rating]).to eq(review3.rating)
      expect(response_hash[3][:rating]).to eq(review2.rating)
    end
  end
end