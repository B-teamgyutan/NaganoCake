class Item < ApplicationRecord
    has_one_attached :image
  enum status: { on_sale: 0, off_sale: 1 }
end
