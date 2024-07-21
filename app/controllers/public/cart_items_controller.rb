class Public::CartItemsController < ApplicationController


  def index
    # @cart_item = Cart_items.new
    # @cart_items = Cart_items.all
  end

  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.update(cart_item_params)
    @cart_items = current_customer.cart_items.all
    @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def destroy
  end

  # def destroy_all
  #   Cart_item.destroy_all
  # end

  def create
    # if cart_item_ｚ
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end
