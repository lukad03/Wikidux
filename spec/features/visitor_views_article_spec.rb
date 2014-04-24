require "spec_helper"

feature 'Articles' do

  scenario 'are listed in the article index' do
    create_articles
    visit '/articles'
    expect(page).to have_selector('div.article', count: 5)
  end

  scenario 'can be read individually' do
    create_article
    visit '/articles'
    click_link('Read Article')

    expect(page).to have_content("Back the truck up!")
  end

  def create_articles
    create_list(:article, 5)
  end

  def create_article
    create(:article)
  end

end
