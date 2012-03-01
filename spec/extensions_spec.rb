require File.dirname(__FILE__) + '/spec_helper'

Factory.sequence(:string){|n| "HelloWorld#{ n }" }

Factory.define :dog do |d|
  d.name do
    if RUBY_VERSION.to_f > 1.8
      Factory.next(:string)
    else
      :string.next
    end
  end
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

  it '"dog".gen and :dog.gen should work' do
    :dog.gen!.should  be_valid
    'dog'.gen!.should be_valid
  end

  it 'Dog.attrs & "dog".attrs & :dog.attrs should return Factory.attributes_for(:dog)' do
    [ Dog, 'dog', :dog ].each do |x|
      %w( attrs attributes attrs_for attributes_for ).each do |msg|
        x.send(msg).keys.should include(:name)
        x.send(msg)[:name].should =~ /HelloWorld\d/
      end
    end
  end

  it ':foo.next should generate the :foo sequence' do
    if RUBY_VERSION.to_f > 1.8
      pending "Symbol#next is unsupported in Ruby 1.9+ (because Ruby implements Symbol#next and we're not going to override it)"
    end

    lambda { :foo.next }.should raise_error(/Sequence not registered: foo/)
    Factory.sequence(:foo){|n| "Foo ##{n}" }
    :foo.next.should  == 'Foo #1'
    :foo.next.should  == 'Foo #2'
  end
end
