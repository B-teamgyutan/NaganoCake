class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
     @order = Order.find(params[:id])
     @order.update(order_params)
     redirect_to admin_order_path(@order)
  end

  private
   def order_params
     params.require(:order).permit(:customer_id, :post_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
   end
end
