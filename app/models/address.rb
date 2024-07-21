class Address < ApplicationRecord
belongs_to :customer

validates :post_code, presence: true, length: { maximum: 7, minimun: 7 },numericality: true
validates :address, presence: true
validates :name, presence: true

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end
