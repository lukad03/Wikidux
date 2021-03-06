require "spec_helper"

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'valid@example.com', 'password'
    expect(page).to have_content('Log Out')
  end

  scenario 'with invalid email' do
    sign_up_with 'invalidexample.com', 'password'
    expect(page).to have_content('Sign Up')
  end

  def sign_up_with(email, password)
    visit '/users/sign_up'

    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'user_password_confirmation', with: password

    click_button 'Sign up'
  end
end
