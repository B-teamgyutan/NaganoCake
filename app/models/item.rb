class Item < ApplicationRecord

  has_many :cart_items

  has_one_attached :image
  # enum is_sold_out: { on_sale: 0, off_sale: 1 }

  def price_with_tax
    (price * 1.1).to_i
  end

end
