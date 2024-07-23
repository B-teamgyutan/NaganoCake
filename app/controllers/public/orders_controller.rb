class Public::OrdersController < ApplicationController
  # before_action :authenticate_member!, only: [:new, :confirm, :create, :indexm :show, :complete]

  def new
  end

  def confirm
      @cart_items = CartItem.where(customer_id:[current_customer.id])
      @order = Order.new
      @postage = 800
  end

  def create
    @cart_items = CartItem.where(customer_id:[current_customer.id])
    @order = Order.new(order_params)
    @postage = 800
    if params[:page] == "new"
      render 'confirm'
    else
      if @order.payment_method == "クレジットカード"
        @order.order_status = 1
      end
      if @order.save
        @cart_items.each do |cart_item|
            OrderItem.create!(order_id: @order.id, count:cart_item.count, item_id:cart_item.item_id, price:cart_item.item.price)
        end
        @cart_items.destroy_all
        redirect_to '/thanks'
      else
        flash[:notice] = "項目に不備があります"
        redirect_to '/orders/new'
      end
    end
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details= OrderDetail.where(order_id: @order.id)
  end

  def thanks
  end

end