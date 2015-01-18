require 'rails_helper'

RSpec.describe KiqsController, :type => :controller do
  render_views

  let(:json) { JSON.parse(response.body, symbolize_names: true) }

  let(:user) { create(:user) }
  let(:stylist) { create(:stylist) }

  before :each do
    user.stylist = stylist
  end

  let!(:kiq) { create(:kiq, user: user, status: 'completed') }
  let!(:kiq_2) { create(:kiq, user: user, status: 'completed') }
  let!(:address) { create(:address, user: user) }

  context 'for users' do
    before :each do
      sign_in user
    end

    describe 'GET index' do
      context 'when not logged in' do
        before :each do
          sign_out user
          get :index, format: :json
        end

        it 'returns 201' do
          expect(response.status).to eq 401
        end
      end

      context 'when logged in' do
        before :each do
          get :index, format: :json
        end

        it 'returns 200' do
          expect(response.status).to eq 200
        end

        it "assigns current user's kiqs to @kiqs" do
          expect(assigns(:kiqs)).to match_array([kiq, kiq_2])
        end
      end
    end

    describe 'GET show' do
      context 'when not logged in' do
        before :each do
          sign_out user
          get :show, format: :json, id: kiq
        end

        it 'returns 401 status' do
          expect(response.status).to eq 401
        end
      end

      context 'when logged in' do
        before :each do
          get :show, format: :json, id: kiq
        end

        it 'assigns the kiq to @kiq' do
          expect(assigns(:kiq)).to eq kiq
        end
      end
    end

    describe 'POST create' do
      context 'when not logged in' do
        before :each do
          sign_out user
          post :create, format: :json
        end

        it 'returns 401 status' do
          expect(response.status).to eq 401
        end
      end

      context 'when logged in' do
        context 'when user has no shipping address' do
          before :each do
            user.address = nil
          end

          it 'does not create a new kiq' do
            expect {
              post :create, format: :json
            }.not_to change(Kiq, :count)
          end
        end

        context 'when user has no credit card' do
          before :each do
            user.stripe_customer_id = nil
          end

          it 'does not create a new kiq' do
            expect {
              post :create, format: :json
            }.not_to change(Kiq, :count)
          end
        end

        context 'when user has no styles' do
          it 'does not create a new kiq' do
            expect {
              post :create, format: :json
            }.not_to change(Kiq, :count)
          end
        end

        context 'when user has no needs' do
          it 'does not create a new kiq' do
            expect {
              post :create, format: :json
            }.not_to change(Kiq, :count)
          end
        end

        context 'when user is ready to order' do
          before :each do
            user.update(stripe_customer_id: 'sample_id', polo_shirt: true, smart_style: true)
          end

          context 'when requested kiq exists' do
            before :each do
              create(:kiq, user: user, status: 'requested')
            end

            it 'does not create a new kiq' do
              expect {
                post :create, format: :json
              }.not_to change(Kiq, :count)
            end
          end

          context 'when no requested kiq exists' do
            it 'creates a new kiq' do
              expect {
                post :create, format: :json
              }.to change(Kiq, :count).by(1)
            end

            it 'sets the kiq to belong to the current user' do
              post :create, format: :json
              expect(Kiq.last.user).to eq user
            end

            it "sets the kiqs to belong to current user's stylist" do
              post :create, format: :json
              expect(Kiq.last.stylist).to eq stylist
            end
          end
        end

      end
    end

    describe 'DELETE destroy' do
      context 'when not logged in' do
        before :each do
          sign_out user
          delete :destroy, format: :json, id: kiq
        end

        it 'returns 401 status' do
          expect(response.status).to eq 401
        end
      end

      context 'when logged in' do
        context "when kiq's status is 'requested'" do
          before :each do
            kiq.update(status: 'requested')
            delete :destroy, format: :json, id: kiq
          end

          it 'cancels the kiq' do
            kiq.reload
            expect(kiq.status).to eq 'cancelled'
          end
        end

        context "when kiq's status is something other than 'requested'" do
          before :each do
            kiq.update(status: 'pending')
            delete :destroy, format: :json, id: kiq
          end

          it 'returns 405 status' do
            expect(response.status).to eq 405
          end
        end

      end
    end
  end

  context 'for stylists' do
    before :each do
      sign_in stylist
    end

    describe 'PUT update' do
      context 'when not logged in' do
        before :each do
          sign_out stylist
          put :update, format: :json, id: kiq
        end

        it 'returns 401 status' do
          expect(response.status).to eq 401
        end
      end

      context 'when logged in' do
        before :each do
          kiq.update(status: 'requested')
        end

        context 'with params[:status] = pending' do
          before :each do
            put :update, format: :json, id: kiq, status: 'pending'
          end

          it 'sets params[:status] as @status' do
            expect(assigns(:status)).to eq 'pending'
          end

          it "updates kiq's status to pending"do
            kiq.reload
            expect(kiq.status).to eq 'pending'
          end
        end

        context 'with params[:status] = completed' do
          before :each do
            put :update, format: :json, id: kiq, status: 'completed'
          end

          it 'sets params[:status] as @status' do
            expect(assigns(:status)).to eq 'completed'
          end

          it "updates kiq's status to completed"do
            kiq.reload
            expect(kiq.status).to eq 'completed'
          end
        end
      end
    end
  end
end
