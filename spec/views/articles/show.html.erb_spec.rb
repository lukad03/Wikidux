require 'spec_helper'

describe 'articles/show.html.erb' do
  it 'displays the article' do
    article = build(:article)
    assign(:article, article)

    render

    expect(rendered).to have_text(article.title)
    expect(rendered).to have_text(article.content)
  end
end
