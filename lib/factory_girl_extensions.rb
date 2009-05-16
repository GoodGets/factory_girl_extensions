$:.unshift File.dirname(__FILE__)

require 'factory_girl'

# Adds helpful factory_girl methods to objects.
#
# This uses method_missing just incase the given Object
# already responds to one of these methods.
#
# == Usage
# 
#   User.generate!             # this is equivalent to Factory(:user) or Factory.create(:user)
#   User.gen!                  # this is a shortcut alias for #generate
#   User.generate              # this is equivalent to Factory.build(:user) and then #save
#   User.gen                   # this is equivalent to Factory.build(:user) and then #save
#   User.build                 # this is equivalent to Factory.build(:user)
#   User.gen! :name => 'Bob'   # this is equivalent to Factory(:user, :name => 'Bob')
#   :email.next                # this is equivalent to Factory.next(:email)
#   'email'.next               # this will NOT work because String#next already exists
#   :admin_user.gen!           # this is equivalent to Factory.gen(:admin_user)
#   'admin_user'.gen!          # this is equivalent to Factory.gen(:admin_user)
#   User.attrs                 # this is equivalent to Factory.attributes_for(:user)
#   'user'.attrs               # this is equivalent to Factory.attributes_for(:user)
#   :user.attrs                # this is equivalent to Factory.attributes_for(:user)
#
# == TODO
#
# * properly implement <tt>respond_to?</tt>
# * add syntax like User.gen_admin or User.gen(:admin) for generating an :admin_user
#
module FactoryGirlExtensions
  def method_missing name, *args
    
    messages = case name.to_s
    when /^gen(erate)?\!$/
      [:build, :save!]
    when /^gen(erate)?$/
      [:build, :save]
    when 'build'
      [:build]
    when 'next'
      [:next]
    when /^attr(ibute)?s(_for)?$/
      [:attributes_for]
    end

    if messages
      # if this is an instance of String/Symbol use this instance as the factory name, else use the class name
      factory_name = ( kind_of?(Symbol) || kind_of?(String) ) ? self.to_s.to_sym : self.name.underscore.to_sym

      factory_method, instance_method = messages
      instance = Factory.send factory_method, factory_name, *args

      if instance_method
        instance.send instance_method if instance.respond_to? instance_method
      end
      
      instance

    else
      super
    end

  end
end

Object.send :include, FactoryGirlExtensions
