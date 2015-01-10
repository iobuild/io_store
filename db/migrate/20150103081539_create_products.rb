class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string   :title
      t.text   :desc
      t.decimal  :price, :null => false, :default => 0
      
      t.timestamps
    end
  end
end
