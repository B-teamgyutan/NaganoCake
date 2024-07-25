class Public::CartItemsController < ApplicationController


  def index
     @cart_items = current_customer.cart_items#.find(params[:id])
     #@cart_item = Cart_item.all
  end

  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.update(cart_item_params)
    @cart_items = current_customer.cart_items.all
    @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
  end
  
  def destroy_all
    CartItem.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.item_id = cart_item_params[:item_id]
    if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.update(amount: cart_item.amount)
      redirect_to cart_items_path
    else
      cart_item.save
      redirect_to cart_items_path
    end
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end
