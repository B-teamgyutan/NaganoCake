class Public::OrdersController < ApplicationController
  
  def new
  end

  def create
    @order = Order.new
    @order.save
    redirect_to orders_confirm_path
  end

  def index
    @order = Order.new
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @new_order = Order.new
  end
  
  def confirm
  end

  def thanks
  end
end

