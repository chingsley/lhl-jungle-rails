require 'rails_helper'

RSpec.feature "Visitor logs in with a username and password", type: :feature, js: true do

  before :each do
    # @password = "supersecret"
    # Yes a factor would be cleaner here, but remember they are just learning this now! ie: out of scope.
    @user = User.create!(
      first_name:  Faker::Name.first_name,
      last_name:  Faker::Name.last_name,
      email: Faker::Internet.email,
      password: 'supersecret',
      password_confirmation: 'supersecret'
    )
  end

  scenario "login works with correct credentials" do
    # ACT
    visit login_path
    # puts page.html

    fill_in 'Email', with: @user.email # 'Email' is the text in <label>Email</label> seen when you log page.html. small case 'email' wont' work, it must be with capital 'E'
    fill_in 'Password', with: @user.password # 'Password' is the text in <label>Password</label> seen when you log page.html. Small case 'password' won't work. It must be with capital 'P'
    click_button 'Submit'

    # VERIFY
    expect(page).to have_text('Logout')

    # DEBUG
    # save_screenshot
    # puts page.html
  end
end