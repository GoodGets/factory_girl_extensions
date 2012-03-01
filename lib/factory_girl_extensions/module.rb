# Just the module.  You should require this if you don't want FactoryGirlExtensions 
# automatically included into Object.

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

  # I was relying on String#underscore being available and it's not always.
  # Copies this from ActiveSupport.
  def underscore_string string
    string.to_s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end

  # This is the actual (private) implementation
  def self.__method_missing object, name, *args, &block
    raise 'Factory is not defined.  Have you required factory_girl?' unless defined? Factory

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
      factory_name = ( object.kind_of?(Symbol) || object.kind_of?(String) ) ? object.to_s.to_sym : underscore_string(object.name).to_sym

      factory_method, instance_method = messages
      instance = Factory.send factory_method, factory_name, *args

      if instance_method
        instance.send instance_method if instance.respond_to? instance_method
      end
      
      instance

    else
      :no_extension_found
    end
  end

  # This is the public implementation.  When you include 
  # FactoryGirlExtensions into a class, this is what gives 
  # you the #gen and other methods.
  def method_missing name, *args, &block
    object = FactoryGirlExtensions.__method_missing(self, name, *args, &block)
    
    # If no extensions were found, call super
    if object == :no_extension_found
      raise NoMethodError.new("Undefined method #{name}")
    else
      object
    end
  end

end
