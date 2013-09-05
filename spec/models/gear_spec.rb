require File.dirname(__FILE__) + '/../spec_helper'

describe Gear do
  it "should be valid" do
    Gear.new.should be_valid
  end
end
