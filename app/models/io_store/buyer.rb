module IoStore
  class Buyer < IoStore.user_class

    has_many :orders, :as => :buyer, :dependent => :destroy, :class_name => "::IoStore::Order"
    has_many :addresses, :as => :buyer, :dependent => :destroy, :class_name => "::IoStore::Address"
    has_one :cart, :as => :buyer, :dependent => :destroy, :class_name => "::IoStore::Cart"


    def has_no_address?
      self.addresses.length == 0
    end

    def set_unique_default(address)
      self.addresses.each do |item|
        if item.id == address.id
          address.is_default = true
          address.save
          next
        end

        item.is_default = false
        item.save

      end

    end


    def default_address
      if self.addresses.where(:is_default => true).exists?
        return self.addresses.where(:is_default => true).first
      end

      a = self.addresses.first
      self.set_unique_default(a)
      a
    end


    def purchase(cart)
      order = Order.create(:buyer => self, :total_amount => cart.amount)

      cart.cart_items.each do |item|
        LineItem.create(
          :order => order,
          :sellable => item.sellable,
          :quantity => item.quantity,
          :amount => item.amount
        )
      end
    end

  end
end