require 'rails_helper'

describe 'New Raffle Requests', :type => :feature do
  # context 'User is signed in' do
    before(:each) do
      # manual_sign_in
      visit '/raffles/new'
    end

    it 'should say "New Raffle"' do
      page.should have_content "New Raffle"
    end

    describe 'Validation Errors' do
      it 'should render the form again' do
        click_button 'Create'
        page.should have_content 'New Raffle'
      end

      it 'should announce the error in the flash' do
        click_button 'Create'
        page.should have_content "Title can't be blank"
        # page.should have_content "Description can't be blank"
        page.should have_content "Ticket price can't be blank"
        page.should have_content "Ticket price is not a number"
      end
    end


    describe 'End to End' do
      specify 'Minimum Parameters' do
        fill_in 'Title', with: 'A Title'
        description = Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..10)).join('<br><br>')
        find(:css, '#raffle_description').set(description)
        fill_in 'Ticket price', with: 1.00
        fill_in 'End time', with: Time.now + Random.rand(1..1000).hours
        expect{ click_button 'Create' }.to change{ Raffle.count }.by(1)

        r = Raffle.last
        r.title.should == 'A Title'
        r.description.should == description
        r.ticket_price.should == 1
      end
    end

  # describe 'Prizes' do
  #   specify 'There should be an embedded form for 1 prize' do
  #     false
  #   end
  # end

  # end #User signed in

  # context 'User is not signed in' do
  #   before(:each) do
  #     visit '/raffles/new'
  #   end

    # it 'should redirect user to sign in' do
    #   page.current_path.should == '/users/sign_in'w
    # end

    # specify 'after sign up, user redirects back to #new' do
    #   click_link 'Sign up'
    #
    #   password = 'a;kldsjfaskn399dkD23'
    #   fill_in 'Email', with: Faker::Internet.email
    #   fill_in 'Password', with: password
    #   fill_in 'Password confirmation', with: password
    #   click_button 'Sign up'
    #
    #   page.current_path.should == "/raffles/new"
    # end
  # end #User is NOT signed in
end
