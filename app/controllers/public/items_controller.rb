class Public::ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item_new = CartItem.new
  end

  private
  def item_params
    params.require(:item).permit(:name, :item_details, :price, :status, :image)
  end

end
