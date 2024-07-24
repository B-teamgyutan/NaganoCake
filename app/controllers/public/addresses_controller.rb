class Public::AddressesController < ApplicationController
  #後で追加する before_action :authenticate_customer!

  def index
		@addresses = Address.where(customer_id:[current_customer.id])
		@address = Address.new
	end

	def edit
		@address = Address.find(params[:id])
		if @address.customer_id != current_customer.id
			redirect_to root_path
		end
	end

	def destroy
		address = Address.find(params[:id])
		address.destroy
		redirect_to '/addresses'
	end

	def create
		address = Address.new(address_params)
		if address.save
			redirect_to '/addresses'
		else
			flash[:notice] = "項目を正しく記入してください"
			redirect_to request.referrer
		end
	end

	def update
		address = Address.find(params[:id])
		if address.update(address_params)
			redirect_to '/addresses'
		else
			flash[:notice] = "項目を正しく記入してください"
			redirect_to request.referrer
		end
	end

	private
	def address_params
		params.require(:address).permit(:customer_id, :post_code, :address, :name)
	end
end