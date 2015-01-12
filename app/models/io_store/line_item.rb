module IoStore
  class LineItem < ActiveRecord::Base

    belongs_to :order, :class_name => "::IoStore::Order"
    belongs_to :sellable, :polymorphic => true


    before_save :save_sellable


    def evaluate
      calculate(self.sellable)
      save(false) if new_record?
    end


    protected

      def calculate(a_sellable)
        self.amount += a_sellable.price if a_sellable && a_sellable.price
      end

      def save_sellable
        sellable.save if sellable && sellable.new_record?
      end

  end
end