module IoStore
  module Sellable
    def self.included(mod)
      mod.extend(ClassMethods)
    end

    module ClassMethods


      def acts_as_sellable(options = {})
        include IoStore::Sellable::InstanceMethods
        extend IoStore::Sellable::SingletonMethods

        has_many :line_items, :as => :sellable, :class_name => "IoStore::LineItem"
        has_many :orders, :through => :line_items, :class_name => "IoStore::Order"
      end
    end

    module SingletonMethods
      def sellable?
        true
      end
    end

    module InstanceMethods

      
    end

  end
end