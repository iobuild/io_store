class Product < ActiveRecord::Base

  # acts_as_sellable

  validates :title, :presence => true
  validates_uniqueness_of :title

end