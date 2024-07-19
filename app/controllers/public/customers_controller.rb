class Public::CustomersController < ApplicationController
  
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end
  
  def update
    customer = current_customer
    customer.update(customer_params)
    radirect_to customers_mypage_path
  end
  
  private
  
  def customer_params
    params.require(:customer).parmit( :last_name,
                                      :first_name,
                                      :last_name_kana,
                                      :first_name_kana,
                                      :post_code,
                                      :address,
                                      :telephone_number,
                                      :email
                                      )
  end
end
