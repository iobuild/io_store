module IoStore
  class Product < ActiveRecord::Base

    has_attached_file :pic, 
      :styles => { 
        :medium => "300x300>", :small => "100x100>", :thumb => "48x48>" 
      }, 
      :default_url => "/images/:style/missing.png"

    validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/

    validates :title, :presence => true
    validates_uniqueness_of :title


  end
end