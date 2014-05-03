require 'spec_helper'

describe Category do
  it { should have_many(:article_categories) }

  it { should have_many(:articles).through (:article_categories) }

  it "has a valid factory" do
    FactoryGirl.build(:category).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:category, name: nil).should_not be_valid
  end

end
