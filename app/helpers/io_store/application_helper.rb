module IoStore
  module ApplicationHelper

    def extract_cart
      return unless current_user

      buyer = Buyer.find(current_user.id)
        
      @cart = buyer.cart

      return @cart if @cart

      IoStore::Cart.create(:buyer => buyer)      
    end


    def show_paid_products(type)
      case type
      when 'product'
        render 'io_store/orders/product'
      when 'cart'
        render 'io_store/orders/cart'
      end
    end


  end
end
