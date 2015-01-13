module IoStore
  class Engine < ::Rails::Engine
    isolate_namespace IoStore

    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end
    end


    config.to_prepare do
      Decorators.register! Engine.root, Rails.root
    end
    
  end
end


require 'alipay'
require 'paperclip'
require 'decorators'
require 'jquery-turbolinks'
require 'bootstrap-sass'
require 'simple_form'
require 'font-awesome-sass'


# We need one of the two pagination engines loaded by this point.
# We don't care which one, just one of them will do.
begin
  require 'kaminari'
rescue LoadError
  begin
    require 'will_paginate'
  rescue LoadError
   puts "Please add the kaminari or will_paginate gem to your application's Gemfile. The io_store engine needs either kaminari or will_paginate in order to paginate."
   exit
  end
end