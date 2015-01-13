FactoryGirl.define do
  factory :product, :class => IoStore::Product do |t|
    t.title 'xxx'
    t.desc 'xxx'
    t.price  3

    # t.buyer {|u| u.association(:user) }
    # t.seller {|u| u.association(:user) }


  end

end
