require 'spec_helper'

describe User do
  it "creates a studio after create" do
    user = FactoryGirl.create(:user)
    user.studio.should_not be_nil
  end
end
