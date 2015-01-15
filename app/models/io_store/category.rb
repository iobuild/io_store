module IoStore
  class Category < ActiveRecord::Base
    acts_as_nested_set


    has_many  :products, :class_name => "::IoStore::Product", :foreign_key => 'category_id'
    validates :name, :presence => true

    scope :by_name, lambda {|name|{:conditions => ['name = ?', name]}}


  end
end