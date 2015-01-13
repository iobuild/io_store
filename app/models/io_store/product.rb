module IoStore
  class Product < ActiveRecord::Base

    has_attached_file :pic, 
      :styles => { 
        :medium => "300x300>", :small => "100x100>", :thumb => "48x48>" 
      }, 
      :default_url => "/assets/missing.png"

    validates_attachment :pic, :presence => true,
      :content_type => { :content_type => /\Aimage\/.*\Z/ },
      :size => { :in => 0..2000.kilobytes }

    validates :title, :presence => true
    validates_uniqueness_of :title


  end
end