require 'spec_helper'

describe ArticleCategory do
  it { should belong_to(:article) }
  it { should belong_to(:category) }
end
