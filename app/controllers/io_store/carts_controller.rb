module IoStore
  class CartsController < IoStore::ApplicationController


    before_filter :authenticate_user!, :pre_load

    def pre_load
      extract_cart if @cart.nil?
    end


    def index
      session.delete(:shopping_product_id) if session[:shopping_product_id]
    end

    def add
      product = Product.find(params[:id])

      @cart.add(product)

      return redirect_to '/store/carts' if params['rel'] == 'carts'

      render :text => @cart.cart_items.length
    end

    def remove_item
      cart_item = IoStore::CartItem.find(params[:id])
      @cart.remove_by_item(cart_item)

      render :template => "io_store/carts/_cart", :locals => {:cart => @cart}, :layout => false
    end


    def remove_selected_items
      items = params[:items]

      return render :nothing => true if items.nil?
      return render :nothing => true if items.length == 0

      items.each do |id|
        cart_item = IoStore::CartItem.find(id)
        @cart.remove_by_item(cart_item)
      end

      render :template => "io_store/carts/_cart", :locals => {:cart => @cart}, :layout => false
    end


    def increase_quantity
      cart_item = IoStore::CartItem.find(params[:id])
      cart_item.update_quantity(params[:new_quantity])

      # render :template => "carts/_cart", :locals => {:cart => @cart}, :layout => false
      render :json => {:cart_amount => @cart.amount, :item_amount => cart_item.amount}
    end

    def decrease_quantity
      cart_item = IoStore::CartItem.find(params[:id])
      cart_item.update_quantity(params[:new_quantity])

      # render :template => "carts/_cart", :locals => {:cart => @cart}, :layout => false
      render :json => {:cart_amount => @cart.amount, :item_amount => cart_item.amount}
    end


  end
end