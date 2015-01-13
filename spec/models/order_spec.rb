require "spec_helper"

describe IoStore::Order do
  before {
    @user = FactoryGirl.create(:user)
    @order = FactoryGirl.create(:order, :buyer => @user)
  }

  it 'order' do
    p IoStore::Order.generate_unique_id
    expect(@order.code).to eq('xxx')
  end

 
  

end