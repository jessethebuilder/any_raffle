require 'rails_helper'

describe 'New Raffle Requests', :type => :feature do
  before(:each) do
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
      within('#the_flash') do
        page.should have_content 'Title cannot be blank'
        page.should have_content 'Description cannot be blank'
        page.should have_content 'Ticket price cannot be blank'
        page.should have_content 'Ticket price is not a number'
      end
    end
  end

  describe 'End to End' do
    specify 'Minimum Parameters' do
      fill_in 'Title', with: 'A Title'
      description = Faker::Lorem.paragraphs(paragraph_count = Random.rand(1..10)).join('<br><br>')
      fill_in 'Description', with: description
      fill_in 'Ticket price', with: 1.00
      expect{ click_button 'Create' }.to change{ Raffle.count }.by(1)

      r = Raffle.last
      r.title.should == 'A Title'
      r.description.should == description
      r.ticket_price.should == 1
    end
  end

end