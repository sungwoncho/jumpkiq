require 'rails_helper'
require 'stripe_mock'

RSpec.describe CustomersController, :type => :controller do
  render_views

  let(:json) { JSON.parse(response.body, symbolize_names: true) }

  let(:user) { create(:user) }

  let(:stripe_helper) { StripeMock.create_test_helper }

  before { StripeMock.start }
  after { StripeMock.stop }

  before :each do
    sign_in user
  end

  describe 'POST create' do
    context 'when not logged in' do
      before :each do
        sign_out user
        post :create, format: :json, stripeToken: '1234stripe'
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end

    context 'when logged in' do

      context 'with valid params' do
        before :each do
          post :create, format: :json, stripeToken: stripe_helper.generate_card_token
        end

        it 'returns 200 status' do
          expect(response.status).to eq 200
        end

        it 'creates a customer' do
          expect(Stripe::Customer.all.count).to eq 1
        end

        it "updates user's stripe_customer_id" do
          user.reload
          expect(user.stripe_customer_id).not_to eq nil
        end
      end

      context 'with invalid params' do
        before :each do
          post :create, format: :json, stripeToken: 'NotValid'
        end

        it 'returns 400' do
          expect(response.status).to eq 400
        end
      end

    end
  end
end
