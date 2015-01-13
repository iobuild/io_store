FactoryGirl.define do
  factory :user, :class => IoStore::Buyer do |f|
    f.username "iostore_user"
    f.email { "bob#{rand(100000)}@boblaw.com" }
    f.password "password"
    f.password_confirmation "password"
  end

end
