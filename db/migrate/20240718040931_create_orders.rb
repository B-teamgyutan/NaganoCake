class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id　
      t.string :post_code             #配送先郵便番号
      t.string :address　　           #配送先住所
      t.string :name　　　            #配送先宛名
      t.integer :shipping_cost        #送料
      t.integer :total_payment        #請求額
      t.integer :payment_method       #支払方法
      t.integer :status, default: 0   #注文ステータス
      t.timestamps
    end
  end
end
