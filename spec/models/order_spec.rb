require "spec_helper"

describe IoStore::Order do
  before {
    # @user = FactoryGirl.create(:user)
    @user = User.create(:name => 'a', :kind => 'a', :email => 'a')
    @order = FactoryGirl.create(:order, :buyer => @user)
  }

  it 'order' do
    p IoStore::Order.generate_unique_id
    expect(@order.code).to eq('xxx')
  end

  it 'created should be true' do
    expect(@order.created?).to eq(true)
  end

  it 'pending should be false' do
    expect(@order.pending?).to eq(false)
  end
  

end