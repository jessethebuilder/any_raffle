require 'rails_helper'

describe 'Farm Slugs Requests', :type => :feature do
  describe 'Raffle Requests' do
    let(:raffle_title){ 'A Regular Old Title' }
    let!(:raffle){ create :raffle, :title => raffle_title }

    describe 'Show' do
      it 'should return a successful request' do
        visit "/raffles/#{raffle_title.parameterize}"
        page.status_code.should == 200
      end

      it 'should display the title' do
        visit "/raffles/#{raffle_title.parameterize}"
        page.should have_content(raffle_title)
      end

    end

    describe 'End to End' do
      before(:each) do
        manual_sign_in
      end

      specify 'A newly created raffle will be findable with its slug' do
        title = 'A Special Title'

        visit "/raffles/new"
        fill_in 'Title', with: title
        fill_in 'Description', with: 'Some Text'
        fill_in 'Ticket price', with: Random.rand(0..1000.0)
        fill_in 'Total number of tickets to sell', with: Random.rand(1..10000)
        click_button 'Create'

        visit "/raffles/a-special-title"
        page.status_code.should == 200
        page.should have_content 'A Special Title'
      end

      specify 'changing raffle title should create a new slug' do
        new_title = 'A New Title'
        visit "/raffles/#{raffle_title.parameterize}/edit"
        fill_in 'Title', :with => new_title
        click_button 'Update'

        visit "/raffles/a-new-title"
        page.status_code.should == 200
        page.should have_content('A New Title')
      end
    end
  end

end