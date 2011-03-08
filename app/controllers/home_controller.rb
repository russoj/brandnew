class HomeController < ApplicationController
  skip_before_filter :require_activation
  
  def index
    @body = "home"
    @topics = Topic.find_recent
    @members = Person.find_recent
    if logged_in?
      @feed = current_person.feed
      @some_contacts = current_person.some_contacts
      @requested_contacts = current_person.requested_contacts
      @products = current_person.my_products
    else
      @feed = Activity.global_feed
      @products = Product.find(:all)
    end    
    respond_to do |format|
      format.html
      format.atom
    end  
  end
end
