require File.dirname(__FILE__) + '/spec_helper'

Factory.sequence(:string){|n| "HelloWorld#{ n }" }

Factory.define :dog do |d|
  d.name { :string.next }
end

describe FactoryGirlExtensions do

  it '#gen[erate] should build and save' do
    Dog.gen.should      be_valid
    Dog.generate.should be_valid

    Dog.gen(      :name => nil ).should_not be_valid
    Dog.generate( :name => nil ).should_not be_valid
  end

  it '#gen[erate]! should build and save!' do
    Dog.gen!.should      be_valid
    Dog.generate!.should be_valid

    lambda { Dog.gen!(      :name => nil ) }.should raise_error
    lambda { Dog.generate!( :name => nil ) }.should raise_error
  end

end
