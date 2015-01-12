require 'active_support/core_ext/kernel/singleton_class'

require "io_store/engine"


module IoStore

  mattr_accessor :user_class, :layout


  class << self


    def decorate_user_class!
      IoStore.user_class.class_eval do

        has_many :topics, :class_name => "IoStore::Topic", :foreign_key => "user_id"
   
        
        # Using +to_s+ by default for backwards compatibility
        def iostore_name
          to_s
        end unless method_defined? :iostore_name

      end
    end

    def user_class
      if @@user_class.is_a?(Class)
        raise "You can no longer set IoStore.user_class to be a class. Please use a string instead.\n\n "
      elsif @@user_class.is_a?(String)
        begin
          Object.const_get(@@user_class)
        rescue NameError
          @@user_class.constantize
        end
      end
    end



    def layout
      @@layout || "io_store/application"
    end


  end

end
