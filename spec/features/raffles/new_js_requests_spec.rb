require 'rails_helper'


describe 'New JS Requests', type: :feature, js: true do
  describe 'Validations' do
    specify 'Form should not submit without valid Title' do
      fill_in_valid_raffle
      fill_in 'Title', with: ''
      click_button 'Create'

      #on a regular validation error, the new page location would be /raffles, but with client-side validation,
      #the user stays on /raffles/new
      page.current_path.should == "/raffles"
    end
  end
end