module IoStore
  class Address < ActiveRecord::Base

    belongs_to :buyer, :polymorphic => true

    validates_presence_of :street, :province

  end
end