require 'rubygems'
require 'spec'
require 'factory_girl'
require File.dirname(__FILE__) + '/../lib/factory_girl_extensions'

# 
# a class that we can use to test factory_girl_extensions with
#
class Dog
  attr_accessor :name, :breed

  def initialize options = {}
    options.each {|k,v| instance_variable_set "@#{k}", v }
  end

  def save
    valid?
  end

  def valid?
    ! @name.blank?
  end

  def save!
    if valid?
      true
    else
      raise 'Invalid Dog!'
    end
  end
end
