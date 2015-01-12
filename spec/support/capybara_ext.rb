module CapybaraExt
  # login helper
  def sign_in(user)
    page.driver.post "/users/sign_in", :user => {
      :email => user.email, :password => user.password
    }
  end

  def sign_out
    page.driver.delete "/users/sign_out"
  end
 

end

RSpec.configure do |config|
  config.include CapybaraExt, :type => :feature
end
