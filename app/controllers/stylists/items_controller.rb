class Stylists::ItemsController < ApplicationController
  before_action :authenticate_stylist!
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :get_items, only: :index

  respond_to :html

  def index
    respond_with(@items)
  end

  def show
    respond_with(@item)
  end

  def new
    @item = Item.new
    respond_with(@item)
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.save
    respond_with(:stylists, @item)
  end

  def update
    @item.update(item_params)
    respond_with(:stylists, @item)
  end

  def destroy
    @item.destroy
    respond_with(:stylists, @item)
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def get_items
      @items = Item.all
    end

    def item_params
      params[:item].permit(:name, :brand, :kind, :status, :value, :purchased_value,
                           :smart, :casual, :hipster, :classic)
    end
end
