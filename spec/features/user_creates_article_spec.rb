require "spec_helper"

feature 'Article creation' do

  pending 'user logs in and creates an article' do
    user = create(:user)
    login_as(user, :scope => :user)
    category = create(:category, :name => 'Sweet Category')

    visit '/articles/new'
    fill_in 'Title', with: 'Interesting Title'
    fill_in 'Content', with: 'Even more interesting article!'
    select('Sweet Category', :from => 'Category')

    click_button 'Create Article'

    expect(page).to have_text('Interesting Title')
    expect(page).to have_link('Sweet Category')

  end

end

