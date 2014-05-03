require 'spec_helper'

describe 'articles/show.html.erb' do
  it 'displays the article' do
    article = build(:article)
    assign(:article, article)

    render

    expect(rendered).to match(article.title)
    expect(rendered).to match(article.content)
  end
end
