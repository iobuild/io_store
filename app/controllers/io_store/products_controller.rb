module IoStore
  class ProductsController < IoStore::ApplicationController


    def index
      @products = IoStore::Product.all
    end

  end
end