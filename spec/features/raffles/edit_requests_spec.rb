require 'rails_helper'

describe 'Edit Requests', type: :feature do
  describe 'Editing an existing Raffle' do
    let!(:raffle){ create :raffle }

    it 'Should include the :title of the Raffle' do
      visit "/raffles/#{raffle.to_param}/edit"
      page.should have_content(raffle.title)
    end

    specify 'The Raffle :title should be a link to #show Raffle' do
      visit "/raffles/#{raffle.to_param}/edit"
      click_link raffle.title
      page.current_path.should == "/raffles/#{raffle.to_param}"
    end
  end

  describe 'End to End' do
    specify 'Create and Edit a Raffle' do
      fill_in_valid_raffle
      click_button 'Create'

      raffle = Raffle.last

      visit "/raffles/#{raffle.to_param}/edit"
      fill_in 'Title', with: 'A Whole Nother Title'
      click_button 'Update'

      raffle.reload
      raffle.title.should == 'A Whole Nother Title'

    end
  end
end