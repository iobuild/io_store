module IoStore
  module Admin
    class CategoriesController < ApplicationController

      before_filter :pre_load

      def pre_load
        @category = IoStore::Category.find(params[:id]) if params[:id]
      end

      def category_params
        params.require(:category).permit(:name, :parent_id)
      end

      def index
        @categories = IoStore::Category.roots
      end

      def new
        @category = IoStore::Category.new
      end

      def create
        @category = IoStore::Category.create(category_params)
        if @category.save
          redirect_to "/store/admin/categories"
        end
      end

      def update
        if @category.update_attributes(category_params)
          redirect_to "/store/admin/categories"
        end
      end

      def destroy
        @category.destroy
        redirect_to :back
      end


    end
  end
end





  