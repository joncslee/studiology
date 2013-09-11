require File.dirname(__FILE__) + '/../spec_helper'

describe Gear do
  it "should load product data into db" do
    Gear.parse_data_from_zzounds
    Gear.count.should > 0
  end
end
