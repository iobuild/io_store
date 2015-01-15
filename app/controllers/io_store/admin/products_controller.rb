module IoStore
  module Admin
    class ProductsController < ApplicationController

      before_filter :pre_load

      def pre_load
        @product = IoStore::Product.with_deleted.find(params[:id]) if params[:id]

        @categories = IoStore::Category.roots
      end


      def product_params
        params.require(:product).permit(:category_id, :title, :desc, :price, :pic)
      end

      def index
        @products = IoStore::Product.order('id desc').page params[:page]
      end

      def trash
        @products = IoStore::Product.only_deleted.order('id desc').page params[:page]
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

        return redirect_to "/store/admin/products/trash" if @product.deleted?
        redirect_to "/store/admin/products"
      end


      def move_to_trash
        items = params[:items]

        return render :nothing => true if items.nil?
        return render :nothing => true if items.length == 0

        items.each do |id|
          product = IoStore::Product.find(id)
          product.delete
        end

        redirect_to "/store/admin/products"
      end


      def clear_selected_trash
        items = params[:items]

        return render :nothing => true if items.nil?
        return render :nothing => true if items.length == 0

        items.each do |id|
          product = IoStore::Product.with_deleted.find(id)
          product.really_destroy!
        end

        redirect_to "/store/admin/products/trash"
      end


      def restore_selected_trash
        items = params[:items]

        return render :nothing => true if items.nil?
        return render :nothing => true if items.length == 0

        Product.restore(items)

        redirect_to "/store/admin/products/trash"
      end



    end
  end
end
