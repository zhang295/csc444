require 'rails_helper'
require 'spec_helper'
# require 'database_cleaner'

RSpec.feature "account sign in/up" do
    scenario "disallow user to sign in with non-exist email" do
        visit new_account_session_path

        fill_in "Email" , with: "nobody@example.com"
        fill_in "Password" , with: "password"
        click_on("Sign In")

        expect(current_path).to eql(new_account_session_path)
    end

    scenario "allow user to sign up the new account" do
        user = FactoryGirl.build(:account)

        visit new_account_registration_path
        fill_in "Name" ,  with: "Test Account"
        fill_in "Email" , with: user.email
        fill_in "Phone number" ,  with: "1234567890"
        fill_in "Password" ,  with: user.password_confirmation
        fill_in "Password confirmation" , with: user.password_confirmation
        page.choose('account_gender_m')
        click_on("Accept and Sign up")

        expect(current_path).to eql(root_path)
    end

    scenario "disallow user to sign in with incorrect password" do
        visit new_account_session_path

        fill_in "Email" , with: "tonyzt132@hotmail.com"
        fill_in "Password" , with: "wrongpassword"
        click_on("Sign In")

        expect(current_path).to eql(new_account_session_path)
    end

    scenario "allow user to sign in with correct infomation" do
        user = FactoryGirl.create(:account)

        visit new_account_session_path
        fill_in "Email" , with: user.email
        fill_in "Password" , with: user.password
        click_on("Sign In")
        expect(page).to have_current_path(root_path)
    end
end

# DatabaseCleaner.clean
