require "spec_helper"

feature 'Visitor navigates to article list' do

  scenario 'and reads through list' do
    create_article
    visit '/articles'
    expect(page).to have_selector(:link_or_button, 'article-1')
  end

  scenario 'and finds an article to read' do
    create_article
    visit '/articles'
    expect(page).to have_selector(:link_or_button, 'article-1')

    click_link('article-1')

  end

  def create_article
    FactoryGirl.create(:article)
  end

end
