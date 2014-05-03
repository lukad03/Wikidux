require 'spec_helper'

describe 'articles/index.html.erb' do
  it 'displays a list of articles' do
    articles = [build_stubbed(:article), build_stubbed(:article)]
    assign(:articles, articles)

    render

    articles.each do |article|
      expect(rendered).to match(article.title)
    end
  end
end
