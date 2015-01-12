module IoStore
  class OrdersController < IoStore::ApplicationController


    before_filter :authenticate_user!, :check_address

    def check_address
      @buyer = Buyer.find(current_user.id)

       add_product_into_cart

      redirect_to "/store/addresses/new" if @buyer.has_no_address?
    end


    def add_product
      
      add_product_into_cart

      redirect_to '/store/orders'
    end



    def index
      @default_address = @buyer.default_address



      @cart = @buyer.cart
      @type = 'cart'
      if session[:shopping_product_id]
        @type = 'product'
        product = Product.find(session[:shopping_product_id])

        @cart_item = @cart.item_for(product)
        @product = @cart_item.sellable
        
      end

      options = {
        :out_trade_no      => '20130801000001',         # 20130801000001
        :subject           => 'Writings.io Base Account x 12',   # Writings.io Base Account x 12
        :logistics_type    => 'DIRECT',
        :logistics_fee     => '0',
        :logistics_payment => 'SELLER_PAY',
        :price             => '10.00',
        :quantity          => 12,
        :discount          => '20.00',
        :return_url        => 'https://writings.io/orders/20130801000001', # https://writings.io/orders/20130801000001
        :notify_url        => 'https://writings.io/orders/20130801000001/alipay_notify'  # https://writings.io/orders/20130801000001/alipay_notify
      }

      @payment_url = Alipay::Service.create_partner_trade_by_buyer_url(options)

      
    end


    private
      def add_product_into_cart
        return unless params[:product_id]
        session[:shopping_product_id] = params[:product_id]

        product = Product.find(session[:shopping_product_id])
        return if @cart.item_for(product.id)

        @cart.add(product)
      end

  end
end