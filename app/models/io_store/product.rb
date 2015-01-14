module IoStore
  class Product < ActiveRecord::Base
    acts_as_paranoid


    has_attached_file :pic, 
      :styles => { 
        :medium => "300x300>", :small => "100x100>", :thumb => "48x48>" 
      }, 
      # :preserve_files => "true",
      :default_url => "/assets/missing.png"


    validates_attachment :pic, :presence => true,
      :content_type => { :content_type => /\Aimage\/.*\Z/ },
      :size => { :in => 0..2000.kilobytes }

    validates :title, :presence => true
    validates_uniqueness_of :title


    before_destroy :remove_cart_item

    def remote_cart_tem
      Cart.item_for(self).destroy
    end


  end
end