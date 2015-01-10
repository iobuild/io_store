module ApplicationHelper

  def show_nav_active(controller, action)
    'active' if params[:action] == action && params[:controller] == controller
  end


  def extract_cart
    return unless current_user

    buyer = Buyer.find(current_user.id)
      
    @cart = buyer.cart

    return @cart if @cart

    IoMerchant::ShoppingCart::Cart.create(:buyer => buyer)

    # buyer.cart.create(:buyer => buyer)
    
  end


  def show_paid_products(type)
    case type
    when 'product'
      render 'orders/product'
    when 'cart'
      render 'orders/cart'
    end
  end

end
