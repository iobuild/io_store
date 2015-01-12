module IoStore
  class Product < ActiveRecord::Base

    validates :title, :presence => true
    validates_uniqueness_of :title


  end
end