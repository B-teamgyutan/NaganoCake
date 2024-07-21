class CartItem < ApplicationRecord
  current_user.cart_items.destroy_all

  # 小計を求めるメソッド
  def subtotal
    item.with_tax_price * amount
  end
end
