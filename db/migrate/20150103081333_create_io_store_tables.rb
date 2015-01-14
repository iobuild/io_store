class CreateIoStoreTables < ActiveRecord::Migration
  def change


    create_table :io_store_products do |t|
      t.string   :title
      t.text   :desc
      t.attachment :pic
      t.decimal  :price, :null => false, :default => 0
      t.datetime  :deleted_at
      
      t.timestamps
    end
    add_index :io_store_products, :deleted_at



    create_table :io_store_addresses do |t|
      t.integer  :buyer_id
      t.string   :buyer_type
      t.string   :firstname
      t.string   :lastname
      t.string   :province
      t.string   :city
      t.string   :sub_city
      t.string   :street
      t.boolean  :is_default, :default => true
      t.datetime :canceled_at

      t.timestamps
    end


    create_table :io_store_orders do |t|
      t.string   :code
      t.integer  :buyer_id
      t.string   :buyer_type
      t.integer  :seller_id
      t.string   :seller_type
      t.decimal  :total_amount
      t.string   :status, :default => 'created', :null => false
      t.datetime :canceled_at

      t.timestamps
    end



    create_table :io_store_line_items do |t|
      t.integer  :order_id
      t.integer  :sellable_id
      t.string   :sellable_type
      t.integer  :quantity, :default => 1, :null => false
      t.integer  :amount,   :default   => 0, :null => false

      t.timestamps
    end


    create_table :io_store_carts do |t|
      t.integer  :buyer_id
      t.string   :buyer_type

      t.timestamps
    end



    create_table :io_store_cart_items do |t|
      t.integer  :cart_id
      t.integer  :sellable_id
      t.string   :sellable_type
      t.string   :name
      t.integer  :quantity, :default => 1, :null => false

      t.timestamps
    end



  end
end