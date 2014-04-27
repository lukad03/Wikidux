require "spec_helper"

feature 'Article creation' do

  scenario 'user logs in and creates an article' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)

    visit '/articles/new'
    fill_in 'Title', with: 'Interesting Title'
    fill_in 'Content', with: 'Even more interesting article!'

    click_button 'Create Article'

    expect(page).to have_content('Interesting Title')

  end

end

