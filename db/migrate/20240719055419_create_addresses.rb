class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      validates :post_code, presence: true, length: { maximum: 7, minimun: 7 },numericality: true
    	validates :address, presence: true
    	validates :name, presence: true
      t.timestamps
    end
  end
end
