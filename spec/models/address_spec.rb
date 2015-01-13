require "spec_helper"

describe IoStore::Address do
  before {
    @user = FactoryGirl.create(:user)
    @buyer = IoStore::Buyer.find(@user.id)
    @address_1 = FactoryGirl.create(:address, :buyer => @buyer)
    @address_2 = FactoryGirl.create(:address, :buyer => @buyer)
    @address_3 = FactoryGirl.create(:address, :buyer => @buyer)

    @buyer.set_unique_default(@address_3)

    @address_1.reload
    @address_2.reload
    @address_3.reload
  }

  it 'address_1 is_default true' do    
    expect(@address_1.is_default).to eq(false)
  end

  it 'address_2 is_default true' do    
    expect(@address_2.is_default).to eq(false)
  end

  it 'address_3 is_default true' do    
    expect(@address_3.is_default).to eq(true)
  end


end