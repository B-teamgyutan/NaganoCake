class Admin::OrderDetailsController < ApplicationController
  
  def update
     @order = Order_detail.find(params[:id])
     @order.update(order_detail_params)
     redirect_to admin_order_path(@order)
  end
  
  private
    params
  
end
