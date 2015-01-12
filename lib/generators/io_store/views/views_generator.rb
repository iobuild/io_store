require 'rails/generators'
module IoStore
  module Generators
    class ViewsGenerator < Rails::Generators::Base #:nodoc:
      source_root File.expand_path("../../../../../app/views/io_store", __FILE__)
      desc "Used to copy io_store's views to your application's views."

      def copy_views
        view_directory :products
        view_directory :addresses
        view_directory :carts
        view_directory :orders
      end

      protected

      def view_directory(name)
        directory name.to_s, "app/views/io_store/#{name}"
      end
    end
  end
end
