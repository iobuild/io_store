module IoStore
  class ProductsController < IoStore::ApplicationController


    def index
      @products = IoStore::Product.order('id desc').page params[:page]
    end

  end
end