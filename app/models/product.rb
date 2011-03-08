
# Schema version: 20110228071111
#
# Table name: people
#
#  id                         :integer(4)      not null, primary key
#  brand_id                   :integer(4)           
#  name                       :string(255)     
#  description                :text            
#  created_at                 :datetime        
#  updated_at                 :datetime
#  parent_id    :integer(4)      
#  content_type :string(255)     
#  filename     :string(255)     
#  thumbnail    :string(255)     
#  size         :integer(4)      
#  width        :integer(4)      
#  height       :integer(4)      

class Product < ActiveRecord::Base  
  include ActivityLogger
  

  UPLOAD_LIMIT = 5 # megabytes
  # Indexed fields for Sphinx
  is_indexed :fields => [ 'name', 'description']
  MAX_CONTENT_LENGTH = 5000
  SEARCH_LIMIT = 20
  SEARCH_PER_PAGE = 8
             
  
  # attr_accessible is a nightmare with attachment_fu, so use
  # attr_protected instead.
  attr_protected :id, :parent_id, :created_at, :updated_at
  
  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :max_size => UPLOAD_LIMIT.megabytes,
                 :min_size => 1,
                 :resize_to => '36x36>'
             #    :thumbnails => { :icon         => '36>',
             #                     :bounded_icon => '36x36>' }
                 #:thumbnail_class => Thumbnail
  
  def exists?(product_id)
    find_by_product_id(product_id).nil?
  end
  
  def self.per_page
    5
  end


  def icon
    #photo.nil? ? "default_icon.png" : public_filename(:icon)
    public_filename()
    #public_filename(:icon)
  end

  def bounded_icon
    #photo.nil? ? "default_icon.png" : public_filename(:bounded_icon)
    public_filename()
    #public_filename(:bounded_icon)
  end 
  
 
  def log_activity
      
  end
    
      # Override the crappy default AttachmentFu error messages.
  def validate
    if filename.nil?
      errors.add_to_base("You must choose a file to upload")
    else
      # Images should only be GIF, JPEG, or PNG
      enum = attachment_options[:content_type]
      unless enum.nil? || enum.include?(send(:content_type))
        errors.add_to_base("You can only upload images (GIF, JPEG, or PNG)")
      end
      # Images should be less than UPLOAD_LIMIT MB.
      enum = attachment_options[:size]
      unless enum.nil? || enum.include?(send(:size))
        msg = "Images should be smaller than #{UPLOAD_LIMIT} MB"
        errors.add_to_base(msg)
      end
    end
  end
  
  

end
