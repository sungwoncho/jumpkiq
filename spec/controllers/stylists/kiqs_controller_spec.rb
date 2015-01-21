require 'rails_helper'

RSpec.describe Stylists::KiqsController, :type => :controller do
  let(:stylist) { create(:stylist) }
  let(:stylist_2) { create(:stylist) }

  before :each do
    sign_in stylist
  end

  describe 'GET index' do
    context 'when not logged in' do
      before :each do
        sign_out stylist
        get :index
      end

      it 'requires login' do
        expect(response).to require_stylist_login
      end
    end

    context 'when logged in' do

      let!(:kiq_1) { create(:kiq, stylist: stylist, status: 'requested') }
      let!(:kiq_2) { create(:kiq, stylist: stylist, status: 'sent') }
      let!(:kiq_3) { create(:kiq, stylist: stylist, status: 'completed') }
      let!(:kiq_4) { create(:kiq, stylist: stylist, status: 'cancelled') }
      let!(:kiq_5) { create(:kiq, stylist: stylist_2) }

      context 'with no params' do
        before :each do
          get :index
        end

        it "assigns all of stylist's kiqs to @kiqs" do
          expect(assigns(:kiqs)).to match_array [kiq_1, kiq_2, kiq_3, kiq_4]
        end
      end

      context 'with some params[:status]' do
        before :each do
          get :index, status: 'requested'
        end

        it "assigns params[:status] to @status" do
          expect(assigns(:status)).to eq 'requested'
        end
      end

      context "with params[:status] = 'requested'" do
        before :each do
          get :index, status: 'requested'
        end

        it 'assigns all requested kiqs to @kiqs' do
          expect(assigns(:kiqs)).to match_array [kiq_1]
        end
      end

      context "with params[:status] = 'sent'" do
        before :each do
          get :index, status: 'sent'
        end

        it 'assigns all pending kiqs to @kiqs' do
          expect(assigns(:kiqs)).to match_array [kiq_2]
        end
      end

      context "with params[:status] = 'completed'" do
        before :each do
          get :index, status: 'completed'
        end

        it 'assigns all completed kiqs to @kiqs' do
          expect(assigns(:kiqs)).to match_array [kiq_3]
        end
      end

      context "with params[:status] = 'cancelled'" do
        before :each do
          get :index, status: 'cancelled'
        end

        it 'assigns all cancelled kiqs to @kiqs' do
          expect(assigns(:kiqs)).to match_array [kiq_4]
        end
      end
    end
  end


  describe 'GET show' do

    let!(:kiq) { create(:kiq) }

    context 'when not logged in' do

      before :each do
        sign_out stylist
        get :show, id: kiq
      end

      it 'requires login' do
        expect(response).to require_stylist_login
      end
    end

    context 'when logged in' do

      before :each do
        get :show, id: kiq
      end

      it 'assigns the requested kiq to @kiq' do
        expect(assigns(:kiq)).to eq kiq
      end
    end
  end


  describe 'GET edit' do

    let!(:kiq) { create(:kiq) }

    context 'when not logged in' do

      before :each do
        sign_out stylist
        get :edit, id: kiq
      end

      it 'requires login' do
        expect(response).to require_stylist_login
      end
    end

    context 'when logged in' do

      before :each do
        get :edit, id: kiq
      end

      it 'assigns the requested kiq to @kiq' do
        expect(assigns(:kiq)).to eq kiq
      end
    end
  end


  describe 'PUT update' do

    let!(:kiq) { create(:kiq, status: 'requested') }

    context 'when not logged in' do

      before :each do
        sign_out stylist
        put :update, id: kiq, kiq: attributes_for(:kiq)
      end

      it 'requires login' do
        expect(response).to require_stylist_login
      end
    end

    context 'when logged in' do

      context 'with valid params' do
        before :each do
          request.env["HTTP_REFERER"] = stylists_kiqs_url unless request.nil? || request.env.nil? # to test redirect_to :back
          put :update, id: kiq, kiq: attributes_for(:kiq, status: 'sent')
        end

        it 'assigns the requested kiq to @kiq' do
          expect(assigns(:kiq)).to eq kiq
        end

        it 'updates the kiq' do
          kiq.reload
          expect(kiq.status).to eq 'sent'
        end

        it 'redirects to kiq' do
          expect(response).to redirect_to :back
        end
      end

    end
  end
end
