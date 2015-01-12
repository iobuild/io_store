# class IoStore::InstallGenerator < Rails::Generators::NamedBase
#   source_root File.expand_path('../templates', __FILE__)
# end


require 'rails/generators'
module IoStore
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option "user-class", :type => :string
      class_option "no-migrate", :type => :boolean
      class_option "current-user-helper", :type => :string

      source_root File.expand_path("../templates", __FILE__)
      desc "Used to install io_store"

      def install_migrations
        puts "Copying over io_store migrations..."
        Dir.chdir(Rails.root) do
          `rake io_store:install:migrations`
        end
      end

      def determine_user_class
        @user_class = options["user-class"].presence ||
                      ask("What is your user class called? [User]").presence ||
                      'User'
      end



      def determine_current_user_helper
        current_user_helper = options["current-user-helper"].presence ||
                              ask("What is the current_user helper called in your app? [current_user]").presence ||
                              :current_user

        puts "Defining io_store_user method inside ApplicationController..."

        io_store_user_method = %Q{
  def io_store_user
    #{current_user_helper}
  end
  helper_method :io_store_user

}

        inject_into_file("#{Rails.root}/app/controllers/application_controller.rb",
                         io_store_user_method,
                         :after => "ActionController::Base\n")

      end

      def add_io_store_initializer
        path = "#{Rails.root}/config/initializers/io_store.rb"
        puts "Adding io_store initializer (config/initializers/io_store.rb)..."
        template "initializer.rb", path
        require path
      end

      def run_migrations
        unless options["no-migrate"]
          puts "Running rake db:migrate"
          `rake db:migrate`
        end
      end

      def seed_database
        load "#{Rails.root}/config/initializers/io_store.rb"
        unless options["no-migrate"]
          puts "Creating default store data"
          IoStore::Engine.load_seed
        end
      end

      def mount_engine
        puts "Mounting IoStore::Engine at \"/io_store\" in config/routes.rb..."
        insert_into_file("#{Rails.root}/config/routes.rb", :after => /routes.draw.do\n/) do
          %Q{
  # This line mounts io_store's routes at /store by default.
  # This means, any requests to the /store URL of your application will go to IoStore::CartsController#index.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as io_store relies on it being the default of "io_store"
  mount IoStore::Engine, :at => '/store'

}
        end
      end


      def create_assets
        create_file Rails.root + "vendor/assets/stylesheets/io_store.css.scss" do
          %Q{
@import "bootstrap-sprockets";
@import "bootstrap";
@import "font-awesome-sprockets";
@import "font-awesome";
@import 'jquery-ui'
@import 'io_store/store';
          }
        end
        create_file Rails.root + "vendor/assets/javascripts/io_store.js" do
          %Q{
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require bootstrap-sprockets
//= require io_store/cart
//= require io_store/address
//= require_tree .
          }
        end
      end

      def finished
        output = "\n\n" + ("*" * 53)
        output += %Q{\nDone! io_store has been successfully installed. Yaaaaay!

Here's what happened:\n\n}

        output += step("io_store's migrations were copied over into db/migrate.\n")
        output += step("A new method called `io_store_user` was inserted into your ApplicationController.
   This lets io_store know what the current user of your application is.\n")
        output += step("A new file was created at config/initializers/io_store.rb
   This is where you put io_store's configuration settings.\n")

        unless options["no-migrate"]
output += step("`rake db:migrate` was run, running all the migrations against your database.\n")
        output += step("Seed store were loaded into your database.\n")
        end
        output += step("The engine was mounted in your config/routes.rb file using this line:

   mount IoStore::Engine, :at => \"/store\"

   If you want to change where the ask are located, just change the \"/ask\" path at the end of this line to whatever you want.")
        output += %Q{\nAnd finally:

#{step("We told you that io_store has been successfully installed and walked you through the steps.")}}
        unless defined?(Devise)
          output += %Q{We have detected you're not using Devise (which is OK with us, really!), so there's one extra step you'll need to do.

   You'll need to define a "sign_in_path" method for io_store to use that points to the sign in path for your application. You can set IoStore.sign_in_path to a String inside config/initializers/io_store.rb to do this, or you can define it in your config/routes.rb file with a line like this:

          get '/users/sign_in', :to => "users#sign_in"

   Either way, io_store needs one of these two things in order to work properly. Please define them!}
        end
        output += "\nIf you have any questions, comments or issues, please post them on our issues page: http://github.com/iobuild/io_store/issues.\n\n"
        output += "Thanks for using io_store!"
        puts output
      end

      private

      def step(words)
        @step ||= 0
        @step += 1
        "#{@step}) #{words}\n"
      end

      def user_class
        @user_class
      end


      def next_migration_number
        last_migration = Dir[Rails.root + "db/migrate/*.rb"].sort.last.split("/").last
        current_migration_number = /^(\d+)_/.match(last_migration)[1]
        current_migration_number.to_i + 1
      end
    end
  end
end
