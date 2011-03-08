# == Schema Information
# Schema version: 20110301132616
#
# Table name: purchases
#
#  id          :integer(4)      not null, primary key
#  person_id   :integer(4)      
#  product_id  :integer(4)      
#  created_at  :datetime        
#  updated_at  :datetime        
#

class Purchase < ActiveRecord::Base
    include ActivityLogger
    
    
    has_many :activities, :foreign_key => "item_id", :dependent => :destroy,
                        :conditions => "item_type = 'Purchase'"
    belongs_to :person
    belongs_to :product 
    
    after_create :log_activity
    
    
  validates_presence_of :person_id, :product_id
    
    def log_activity
      activity = Activity.create!(:item => self, :person => person)
      add_activities(:activity => activity, :person => person)
      
    end
    class << self
  
    # Return true if the persons are (possibly pending) connections.
    def exists?(person, product)
      not conn(person, product).nil?
    end
    
    # Return a connection based on the person and contact.
    def conn(person, product)
      find_by_person_id_and_product_id(person, product)
    end
    
    alias exist? exists?
  # Make a pending connection request.
    def add(person, product)
      if Purchase.exists?(person, product)
        nil
      else
        transaction do
          create(:person_id => person, :product_id => product)
        end
      end
      true
    end
    

  end
end
