module IoStore
  class Order < ActiveRecord::Base

    belongs_to :seller, :polymorphic => true
    belongs_to :buyer, :polymorphic => true
    has_many   :line_items, :dependent => :destroy, :class_name => "::IoStore::LineItem"


    before_save :get_code

    class << self

      def generate_unique_id
        value = Digest::MD5.hexdigest("#{Time.now.utc.to_i}#{rand(2 ** 128)}")[0..12]
        value.encode! 'utf-8'
        value
      end

    end


    def get_code
      self.class.generate_unique_id
    end


    def build_addresses(options={})
      raise "override in purchase_order or sales_order"
    end


    # is the number of line items stored in the order, though not to be
    # confused by the items_count
    def line_items_count
      self.line_items.count
    end


  end
end