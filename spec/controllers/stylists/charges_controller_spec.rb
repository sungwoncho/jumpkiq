require 'rails_helper'
require 'stripe_mock'

RSpec.describe Stylists::ChargesController, :type => :controller do

  let(:json) { JSON.parse(response.body, symbolize_names: true) }

  let!(:stylist) { create(:stylist) }
  let!(:user) { create(:user) }
  let!(:kiq) { create(:kiq, user: user, stylist: stylist, status: 'requested') }

  let(:stripe_helper) { StripeMock.create_test_helper }

  before { StripeMock.start }
  after { StripeMock.stop }

  before :each do
    customer = Stripe::Customer.create({card: stripe_helper.generate_card_token})
    user.update(stripe_customer_id: customer.id)
    sign_in stylist
  end

  describe 'POST create' do
    context 'when not logged in' do
      before :each do
        sign_out stylist
        post :create, id: kiq
      end

      it 'return 401 status' do
        expect(response).to require_stylist_login
      end
    end

    context 'when logged in' do
      context "when the kiq's status is 'sent'" do
        before :each do
          request.env["HTTP_REFERER"] = stylists_kiqs_url unless request.nil? || request.env.nil? # to test redirect_to :back
          kiq.update(status: 'sent')
          post :create, id: kiq, amount: 80
        end

        it "assigns the kiq to @kiq" do
          expect(assigns(:kiq)).to eq kiq
        end

        it "assigns the kiq's user to @user" do
          expect(assigns(:user)).to eq user
        end

        it "assigns the param[:amount] to @amount" do
          expect(assigns(:amount)).to eq 80
        end

        it 'charges the customer' do
          expect(assigns(:payment).paid).to be true
        end

        it 'charges the customer the correct amount' do
          expect(assigns(:payment).amount).to eq 80
        end

        it 'redirects back' do
          expect(response).to redirect_to :back
        end

        it "updates the kiqs status to 'completed'" do
          kiq.reload
          expect(kiq.status).to eq 'completed'
        end
      end

      context "when the kiq's status is not 'sent'" do
        before :each do
          post :create, id: kiq
        end

        it 'does not charge customer' do
          expect(assigns(:payment)).to be_nil
        end

        it 'returns 405' do
          expect(response.status).to eq 405
        end
      end
    end
  end

end
