class CreateUsers < ActiveRecord::Migration
  create_table :users, :force => true do |t|
    t.string  :email,                             :default => "",    :null => false
    t.string  :encrypted_password, :limit => 128, :default => "",    :null => false
    t.string  :username
    t.string  :avatar
  end

  add_index :users, :email, :unique => true
end
