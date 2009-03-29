require File.dirname(__FILE__) + '/spec_helper'

#
# make sure our example class works as expected
#
describe Dog do

  it 'should have a name' do
    Dog.new.name.should be_nil
    Dog.new( :name => 'Rover' ).name.should == 'Rover'
  end

  it 'should have a breed' do
    Dog.new.breed.should be_nil
    Dog.new( :breed => 'American Pit Bull Terrier' ).breed.should == 'American Pit Bull Terrier'
  end

  it 'should require a name' do
    Dog.new.should_not be_valid
    Dog.new( :name => 'rover' ).should be_valid
  end

  it 'should return true/false if #save OK' do
    Dog.new.save.should be_false
    Dog.new.should_not be_valid
    Dog.new( :name => 'rover' ).should be_valid
    Dog.new( :name => 'rover' ).save.should be_true  
  end

  it 'should raise an exception if not #save! OK' do
    lambda { Dog.new.save! }.should raise_error
    Dog.new( :name => 'rover' ).save!.should be_true
  end

end
