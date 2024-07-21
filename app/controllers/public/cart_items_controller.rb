class Public::CartItemsController < ApplicationController


  def index
    # @cart_item = Cart_items.new
    # @cart_items = Cart_items.all
  end

  def update
  end

  def destroy
  end

  # def destroy_all
  #   Cart_item.destroy_all
  # end

  def create
    # if cart_item_e
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end
