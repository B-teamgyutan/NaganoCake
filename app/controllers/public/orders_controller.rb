class Public::OrdersController < ApplicationController
  # before_action :authenticate_member!

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new
    @payment_method = params[:payment_method]
    if @order.save
      # 保存成功した場合の処理
    else
      # 保存失敗した場合の処理
      @order.errors.full_messages
    end
    @shipping_fee = 800

  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id =  @order.id
      @order_detail.item_id =  cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = (cart_item.item.price*1.1).floor
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to thanks_orders_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details

    # @order_details= OrderDetail.where(order_id: @order.id)
    # redirect_to confirm_orders_path(id: @order.id)
  end

  def thanks
  end

  private

    def order_params
      params.require(:order).permit(:customer_id, :post_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
    end

end