require 'rails_helper'

RSpec.describe '/products', type: :request do
  let(:valid_attributes) { attributes_for(:product) }
  let(:invalid_attributes) { valid_attributes.merge(price: nil) }

  describe 'GET /index' do
    let!(:product) { Product.create! valid_attributes }

    before { get products_url, as: :json }

    it { expect(response).to have_http_status(:ok) }

    it 'renders a JSON response with a list of products' do
      expect(response.body).to include_json(
        [
          {
            id: product.id,
            name: product.name,
            description: product.description,
            price: product.price.as_json,
            quantity: product.quantity,
            created_at: product.created_at.as_json,
            updated_at: product.updated_at.as_json
          }
        ]
      )
    end
  end

  describe 'GET /show' do
    context 'with existent id' do
      let(:product) { Product.create! valid_attributes }

      before { get product_url(product), as: :json }

      it { expect(response).to have_http_status(:ok) }

      it 'renders a JSON response with the product' do
        expect(response.body).to include_json(
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price.as_json,
          quantity: product.quantity,
          created_at: product.created_at.as_json,
          updated_at: product.updated_at.as_json
        )
      end
    end

    context 'with non-existent id' do
      before { get product_url(22), as: :json }

      it { expect(response).to have_http_status(404) }

      it 'renders a JSON response with errors' do
        json_data = JSON.parse(response.body, symbolize_names: true)
        expect(json_data).to eq(errors: ["Couldn't find Product with 'id'=22"])
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Product' do
        expect {
          post products_url, params: { product: valid_attributes }, as: :json
        }.to change(Product, :count).by(1)
      end

      it 'renders a JSON response with the new product' do
        post products_url, params: { product: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)

        expect(response.body).to include_json(
          id: a_kind_of(Integer),
          name: valid_attributes[:name],
          description: valid_attributes[:description],
          price: valid_attributes[:price].to_d.as_json,
          quantity: valid_attributes[:quantity],
          created_at: a_kind_of(String),
          updated_at: a_kind_of(String)
        )
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Product' do
        expect {
          post products_url, params: { product: invalid_attributes }, as: :json
        }.to change(Product, :count).by(0)
      end

      before do
        post products_url, params: { product: invalid_attributes }, as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it 'renders a JSON response with errors for the new product' do
        json_data = JSON.parse(response.body, symbolize_names: true)
        expect(json_data).to eq(errors: ["Price can't be blank"])
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:product) { Product.create! valid_attributes }
      let(:new_attributes) { { price: product.price + 10 } }

      it 'updates the requested product' do
        patch product_url(product), params: { product: new_attributes }, as: :json
        product.reload
        expect(product.price).to eq new_attributes[:price]
      end

      it 'renders a JSON response with the product' do
        patch product_url(product), params: { product: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)

        expect(response.body).to include_json(
          id: product.id,
          name: product.name,
          description: product.description,
          price: new_attributes[:price].as_json,
          quantity: product.quantity,
          created_at: product.created_at.as_json,
          updated_at: product.reload.updated_at.as_json
        )
      end
    end

    context 'with invalid parameters' do
      let(:product) { Product.create! valid_attributes }

      before do
        patch product_url(product), params: { product: invalid_attributes }, as: :json
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it 'renders a JSON response with errors for the product' do
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested product' do
      product = Product.create! valid_attributes
      expect { delete product_url(product), as: :json }.to change(Product, :count).by(-1)
    end
  end
end
