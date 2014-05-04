require 'spec_helper'

describe Article do
  it "has a valid factory" do
    FactoryGirl.build(:article).should be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:article, title: nil).should_not be_valid
  end

  it "is invalid without content" do
    FactoryGirl.build(:article, content: nil).should_not be_valid
  end

  it { should belong_to(:user) }

  it { should have_many(:article_categories) }

  it { should have_many(:categories).through (:article_categories) }

end
