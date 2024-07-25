class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
   #current_customer.cart_items.destroy_all

  # 小計を求めるメソッド
  def subtotal
    item.price * amount
  end
end
