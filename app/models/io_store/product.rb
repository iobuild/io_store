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


    belongs_to :category, :class_name => "::IoStore::Category", :foreign_key => 'category_id'

    validates :title, :presence => true
    validates_uniqueness_of :title


  end
end