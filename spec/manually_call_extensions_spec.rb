require File.dirname(__FILE__) + '/spec_helper'

describe 'Should be able to manually fire off the "method_missing" calls' do

  it 'should be able to generate a Dog manually' do
    dog = FactoryGirlExtensions.__method_missing(Dog, :gen)
    dog.name.should =~ /HelloWorld\d+/
  end

end
