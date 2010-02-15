$LOAD_PATH.unshift File.dirname(__FILE__)

require 'factory_girl_extensions/module'

Object.send :include, FactoryGirlExtensions
