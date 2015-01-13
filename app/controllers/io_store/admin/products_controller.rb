module IoStore
  module Admin
    class ProductsController < ApplicationController

      before_filter :pre_load

      def pre_load
        @product = IoStore::Product.find(params[:id]) if params[:id]
      end


      def product_params
        params.require(:product).permit(:title, :desc, :price, :pic)
      end

      def index
        @products = IoStore::Product.order('id desc').page params[:page]
      end

      def new
        @product = IoStore::Product.new
      end

      def create
        @product = IoStore::Product.create( product_params )
        redirect_to "/store/admin/products"
      end


      def update
        @product.update_attributes(product_params)

        redirect_to "/store/admin/products"
      end


      def destroy
        @product.pic = nil
        @product.save
        @product.destroy

        redirect_to "/store/admin/products"
      end



    end
  end
end
