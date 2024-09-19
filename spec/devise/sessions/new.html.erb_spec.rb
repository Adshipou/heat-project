# require 'rails_helper'
#
# RSpec.describe "Login Form", type: :feature do
#   describe "Rainy Day Test Cases" do
#     it "displays an error message for invalid input" do
#       visit new_user_session_path
#
#       fill_in 'Email', with: 'invalid_email'
#       fill_in 'Password', with: 'password123'
#       click_button 'Log in'
#
#       expect(page).to have_content('Invalid email or password.')
#     end
#
#     it "displays an error message for authentication failure" do
#       visit new_user_session_path
#
#       # Create a user record
#       user = User.create(email: 'test@example.com', password: 'password123')
#
#       fill_in 'Email', with: user.email
#       fill_in 'Password', with: 'incorrect_password'
#       click_button 'Log in'
#
#       expect(page).to have_content('Invalid email or password.')
#     end
#   end
#
#   describe "Sunny Day Test Case" do
#     it "redirects to the home page after successful login" do
#       # Create a user record
#       user = User.create(email: 'test@example.com', password: 'password123')
#
#       visit new_user_session_path
#       fill_in 'Email', with: user.email
#       fill_in 'Password', with: user.password
#       click_button 'Log in'
#
#       expect(page).to have_current_path(root_path)
#       expect(page).to have_content("Welcome, #{user.username}!")
#     end
#   end
# end
