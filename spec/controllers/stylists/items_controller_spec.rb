require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe Stylists::ItemsController, :type => :controller do

  let(:stylist) { create(:stylist) }

  before :each do
    sign_in stylist
  end

  describe "GET index" do
    it 'requires stylist login' do
      sign_out stylist
      get :index
      expect(response).to require_stylist_login
    end

    it "assigns all items as @items" do
      item = create(:item)
      get :index
      expect(assigns(:items)).to eq([item])
    end
  end

  describe "GET show" do
    it 'requires stylist login' do
      sign_out stylist

      item = create(:item)
      get :show, id: item
      expect(response).to require_stylist_login
    end

    it "assigns the requested item as @item" do
      item = create(:item)
      get :show, id: item
      expect(assigns(:item)).to eq(item)
    end
  end

  describe "GET new" do
    it 'requires stylist login' do
      sign_out stylist

      get :new
      expect(response).to require_stylist_login
    end

    it "assigns a new item as @item" do
      get :new
      expect(assigns(:item)).to be_a_new(Item)
    end
  end

  describe "GET edit" do
    it 'requires stylist login' do
      sign_out stylist

      item = create(:item)
      get :edit, id: item
      expect(response).to require_stylist_login
    end

    it "assigns the requested item as @item" do
      item = create(:item)
      get :edit, id: item
      expect(assigns(:item)).to eq(item)
    end
  end

  describe "POST create" do

    it 'requires stylist login' do
      sign_out stylist

      post :create, item: attributes_for(:item)
      expect(response).to require_stylist_login
    end

    describe "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, item: attributes_for(:item)
        }.to change(Item, :count).by(1)
      end

      it "assigns a newly created item as @item" do
        post :create, item: attributes_for(:item)
        expect(assigns(:item)).to be_a(Item)
        expect(assigns(:item)).to be_persisted
      end

      it "redirects to the created item" do
        post :create, item: attributes_for(:item)
        expect(response).to redirect_to(stylists_item_path(Item.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved item as @item" do
        post :create, item: attributes_for(:item, name: nil)
        expect(assigns(:item)).to be_a_new(Item)
      end

      it "re-renders the 'new' template" do
        post :create, item: attributes_for(:item, name: nil)
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do

    let(:item) { create(:item, name: 'Boss Orange Jacket') }

    it 'requires stylist login' do
      sign_out stylist

      put :update, id: item, item: attributes_for(:item, name: 'Uniqlo shirt')
      expect(response).to require_stylist_login
    end

    describe "with valid params" do

      before :each do
        put :update, id: item, item: attributes_for(:item, name: 'Uniqlo shirt')
      end

      it "updates the requested item" do
        item.reload
        expect(item.name).to eq 'Uniqlo shirt'
      end

      it "assigns the requested item as @item" do
        expect(assigns(:item)).to eq(item)
      end

      it "redirects to the item" do
        expect(response).to redirect_to(stylists_item_path(item))
      end
    end

    describe "with invalid params" do

      before :each do
        put :update, id: item, item: attributes_for(:item, name: nil)
      end

      it "assigns the item as @item" do
        expect(assigns(:item)).to eq(item)
      end

      it "re-renders the 'edit' template" do
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do

    before :each do
      @item = create(:item)
    end

    it 'requires stylist login' do
      sign_out stylist

      delete :destroy, id: @item
      expect(response).to require_stylist_login
    end

    it "destroys the requested item" do
      expect {
        delete :destroy, id: @item
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      delete :destroy, id: @item
      expect(response).to redirect_to(stylists_items_url)
    end
  end

end
