class Public::OrdersController < ApplicationController
  # before_action :authenticate_member!, only: [:new, :confirm, :create, :indexm :show, :complete]

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
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order = Order.new(order_params)
    @shipping_fee = 800
    if @order.payment_method == "クレジットカード"
      @order.order_status = 1
    end

    if @order.save
      @cart_items.each do |cart_item|
        OrderItem.create!(order_id: @order.id, count: cart_item.count, item_id: cart_item.item_id, price: cart_item.item.price)
      end

      @cart_items.destroy_all
      redirect_to '/thanks'
    else
      flash[:notice] = "項目に不備があります"
      render :new  # 注文入力画面を再表示してエラーメッセージを表示します
    end
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_details= OrderDetail.where(order_id: @order.id)
    redirect_to confirm_orders_path(id: @order.id)
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:post_code, :address, :name, :shipping_cost, :total_payment,:payment_method, :status)
  end

end