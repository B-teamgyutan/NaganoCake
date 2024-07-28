class Public::OrdersController < ApplicationController
  # before_action :authenticate_member!

  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def confirm

    @order = Order.new(order_params)

    @payment_method = params[:order][:payment_method]
    @shipping_cost = 800

    # if文を記述して、hidden fieldが作動するようにする。
    # ご自身の住所と配送先住所が選択された場合はhiddenで処理

    # 登録新規登録時の住所
    if params[:order][:address_type] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name

      # 追加登録した住所
    elsif params[:order][:address_type] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.post_code
      @order.address = @address.address
      @order.name = @address.name

      # 新規住所入力
    elsif params[:order][:address_type] == "2"
      @order.post_code = params[:order][:post_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render 'new'
    end

    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_customer.id
  end

  def create
    @shipping_cost = 800
    if params[:address_type] == "member_address"
      @address_type = "ご自身の住所"
      @post_code = current_customer.post_code
      @address = current_customer.address
      @full_name = current_customer.full_name
    elsif params[:address_type] == "registered_address"
      # 登録済み住所に関する処理
    elsif params[:address_type] == "new_address"
      # 新しいお届け先に関する処理
    end

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
  end

  def thanks
  end

  private

    def order_params
      params.require(:order).permit(:customer_id, :post_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
    end
end