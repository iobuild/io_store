module IoStore
  class Order < ActiveRecord::Base
    include AASM

    belongs_to :seller, :polymorphic => true
    belongs_to :buyer, :polymorphic => true
    has_many   :line_items, :dependent => :destroy, :class_name => "::IoStore::LineItem"


    #--- state machine
    aasm :column => "status" do
      state :created,   :enter => :enter_created,   :exit => :exit_created, :initial => true
      state :pending,   :enter => :enter_pending,   :exit => :exit_pending
      state :approved,  :enter => :enter_approved,  :exit => :exit_approved
      state :shipping,  :enter => :enter_shipping,  :exit => :exit_shipping
      state :shipped,   :enter => :enter_shipped,   :exit => :exit_shipped
      state :received,  :enter => :enter_received,  :exit => :exit_received
      state :returning, :enter => :enter_returning, :exit => :exit_returning
      state :returned,  :enter => :enter_returned,  :exit => :exit_returned
      state :refunded,  :enter => :enter_refunded,  :exit => :exit_refunded
      state :canceled,  :enter => :enter_canceled,  :exit => :exit_canceled

      event :process_payment do
        transitions :from      => :created, :to => :pending, :guard => :guard_process_payment_from_created
      end

      event :approve_payment do
        transitions :from      => :pending, :to => :approved, :guard => :guard_approve_payment_from_pending
      end

      event :process_shipping do
        transitions :from      => :approved, :to => :shipping, :guard => :guard_process_shipping_from_approved
      end

      event :ship do
        transitions :from      => :shipping, :to => :shipped, :guard => :guard_ship_from_shipping
      end

      event :confirm_reception do
        transitions :from      => :shipped, :to => :received, :guard => :guard_confirm_reception_from_shipped
      end

      event :reject do
        transitions :from      => :received, :to => :returning, :guard => :guard_reject_from_received
      end

      event :confirm_return do
        transitions :from      => :returning, :to => :returned, :guard => :guard_confirm_return_from_returning
        transitions :from      => :shipped, :to => :returned, :guard => :guard_confirm_return_from_shipped
      end

      event :refund do
        transitions :from      => :returned, :to => :refunded, :guard => :guard_refund_from_returned
      end

      event :cancel do
        transitions :from      => :created, :to => :canceled, :guard => :guard_cancel_from_created
        transitions :from      => :pending, :to => :canceled, :guard => :guard_cancel_from_pending
      end
    end

    # state transition callbacks, to be overwritten
    def enter_created; end
    def enter_pending; end
    def enter_approved; end
    def enter_shipping; end
    def enter_shipped; end
    def enter_received; end
    def enter_returning; end
    def enter_returned; end
    def enter_refunded; end
    def enter_canceled; end

    def exit_created; end
    def exit_pending; end
    def exit_approved; end
    def exit_shipping; end
    def exit_shipped; end
    def exit_received; end
    def exit_returning; end
    def exit_returned; end
    def exit_refunded; end
    def exit_canceled; end

    # event guard callbacks, to be overwritten
    def guard_process_payment_from_created; true; end
    def guard_approve_payment_from_pending; true; end
    def guard_process_shipping_from_approved; true; end
    def guard_ship_from_shipping; true; end
    def guard_confirm_reception_from_shipped; true; end
    def guard_reject_from_received; true; end
    def guard_confirm_return_from_returning; true; end
    def guard_confirm_return_from_shipped; true; end
    def guard_refund_from_returned; true; end
    def guard_cancel_from_created; true; end
    def guard_cancel_from_pending; true; end

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