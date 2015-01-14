module IoStore
  class Category < ActiveRecord::Base
    acts_as_nested_set

    validates :name, :presence => true

    scope :by_name, lambda {|name|{:conditions => ['name = ?', name]}}


  end
end