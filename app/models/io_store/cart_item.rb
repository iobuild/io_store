module IoStore
  class CartItem < ActiveRecord::Base

    belongs_to :sellable, :polymorphic => true
    belongs_to :cart, :class_name => "::IoStore::Cart"


    def amount
      return 0 if self.sellable.nil?
      self.quantity * self.sellable.price
    end

    def update_quantity(new_quantity)
      self.quantity = new_quantity
      self.save
    end


    module InstanceMethods

      # # Get cart item by a product/sellable
      def item_for(a_sellable)
        cart_items.where(:sellable => a_sellable).first
      end


      def update_quantity_for(a_sellable, new_quantity)
        item = item_for(a_sellable)
        item.update_attributes(:quantity => new_quantity) if item
      end

    end


  end
end