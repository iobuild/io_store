FactoryGirl.define do
  factory :address, :class => IoStore::Address do |t|
    t.province 'xxx'
    t.city 'xx'
    t.sub_city  'x'
    t.street 'm'
    t.is_default true

    t.buyer {|u| u.association(:user) }

  end

end
