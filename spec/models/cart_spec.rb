require "spec_helper"

describe IoStore::Cart do
  before {
    @cart = FactoryGirl.create(:cart)
    @product_1 = FactoryGirl.create(:product, :title => 'xx1')
    @product_2 = FactoryGirl.create(:product, :title => 'xx2')
    @cart_item_1 = FactoryGirl.create(:cart_item, :sellable => @product_1, :cart => @cart)
    @cart_item_2 = FactoryGirl.create(:cart_item, :sellable => @product_2, :cart => @cart)
  }

  it 'cart_items length' do
    expect(@cart.cart_items.length).to eq(2)
  end

  it 'cart amount' do
    expect(@cart.amount.to_i).to eq(6)
  end





  describe 'empty cart' do

    before {
      @cart.clear
    }

    it 'cart_items length' do
      expect(@cart.cart_items.length).to eq(0)
    end

    it 'empty?' do
      expect(@cart.empty?).to eq(true)
    end

    it 'cart amount' do
      expect(@cart.amount.to_i).to eq(0)
    end

  end



  describe 'add product' do

    before {
      @product = FactoryGirl.create(:product, :title => 'xx3')
      @cart_new_item = @cart.add(@product, 2)
    }

    it 'cart_items length' do
      expect(@cart.cart_items.length).to eq(3)
    end

    it 'cart amount' do
      expect(@cart.amount.to_i).to eq(12)
    end

    it 'remove product' do
      @cart.remove_by_sellable(@product)
      @cart.reload

      expect(@cart.cart_items.length).to eq(3)
    end

    describe 'remove item1' do
      before {
        @cart.remove_by_item(@cart_item_1)
      }

      it 'cart length' do
        expect(@cart.cart_items.length).to eq(2)
      end

      it 'cart amount' do
        expect(@cart.amount.to_i).to eq(9)
      end
    end

    describe 'remove item2' do
      before {
        @cart.remove_by_item(@cart_item_2)
        @cart.reload
      }

      it 'cart amount' do
        expect(@cart.amount.to_i).to eq(9)
      end
    end


    describe 'update cart item quantity' do
      before {
        @cart.update_quantity_for(@product, 1)
      }

      it 'cart_items length' do
        expect(@cart.cart_items.length).to eq(3)
      end

      it 'cart amount' do
        expect(@cart.amount.to_i).to eq(9)
      end
    end





  end

  

end