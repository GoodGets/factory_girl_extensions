$:.unshift File.dirname(__FILE__)

require 'factory_girl'

# Adds helpful factory_girl methods to objects.
#
# This uses method_missing just incase the given Object
# already responds to one of these methods.
#
# == Usage
# 
#   User.generate              # this is equivalent to Factory(:user) or Factory.create(:user)
#   User.gen                   # this is a shortcut alias for #generate
#   User.build                 # this is equivalent to Factory.build(:user)
#   User.gen :name => 'Bob'    # this is equivalent to Factory(:user, :name => 'Bob')
#   :email.next                # this is equivalent to Factory.next(:email)
#   :admin_user.gen            # this is equivalent to Factory.gen(:admin_user)
#   'admin_user'.gen           # this is equivalent to Factory.gen(:admin_user)
#
# == TODO
#
# * properly implement <tt>respond_to?</tt>
# * add syntax like User.gen_admin or User.gen(:admin) for generating an :admin_user
#
module FactoryGirlExtensions
  def method_missing name, *args
    
    message = case name.to_s
    when /^gen(erate)?$/
      :create
    when 'build'
      :build
    when 'next'
      :next
    end

    if message
      # if this is an instance of String/Symbol use this instance as the factory name, else use the class name
      factory_name = ( kind_of?(Symbol) || kind_of?(String) ) ? self.to_s.to_sym : self.name.underscore.to_sym
      Factory.send message, factory_name, *args
    else
      super
    end

  end
end

Object.send :include, FactoryGirlExtensions
