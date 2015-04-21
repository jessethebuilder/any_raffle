require 'rails_helper'

describe 'Index Requests', type: :feature do
  let!(:raffle){ create :raffle }
  let!(:other_raffle){ create :raffle }

  specify 'Returns all Raffles' do
    visit '/raffles'
    page.should have_content(raffle.title)
    page.should have_content(other_raffle.title)
  end

end