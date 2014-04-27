require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.build(:user).should be_valid
  end
  it "is invalid without an email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end
  it "is invalid without a properly formatted email" do
    FactoryGirl.build(:user, email: 'test').should_not be_valid
  end
  it "is invalid without a password" do
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end
  it "is invalid when passwords do not match" do
    FactoryGirl.build(:user, password_confirmation: 'password2').should_not be_valid
  end
  it { should have_many(:articles) }
end
