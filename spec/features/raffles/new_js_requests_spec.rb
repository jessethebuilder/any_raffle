# require 'rails_helper'
#
# def fill_in_valid_raffle
#   visit '/raffles/new'
#
#   # find(:css, "textarea[id='raffle_description']").set Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..10)).join('<br><br>')
#
#   fill_in 'Title', with: Faker::Commerce.product_name
#   fill_in '#raffle_description', with: Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..10)).join('<br><br>')
#   fill_in 'Ticket price', with: Random.rand(0..1000.0)
# end
#
# describe 'New JS Requests', type: :feature, js: true do
#   describe 'Validations' do
#     specify 'Form should not submit without valid Title' do
#       fill_in_valid_raffle
#       fill_in 'Title', with: ''
#       click_button 'Create'
#
#       #on a regular validation error, the new page location would be /raffles, but with client-side validation,
#       #the user stays on /raffles/new
#       page.current.should == "/raffles"
#     end
#   end
# end