class CreateCategories < ActiveRecord::Migration
  create_table :categories, :force => true do |t|
    t.string  :name,                             :default => "",    :null => false
  end

end
