require 'rails_helper'

RSpec.describe Prize, type: :model do
  let(:prize){ build :prize }

  describe 'Validations' do
    it{ should validate_presence_of :raffle_id }

    it{ should validate_presence_of :name }
  end

  describe 'Associations' do
    it{ should have_one :ticket }
    it{ should belong_to :raffle }
  end

  describe 'Methods' do
    describe '#pick_winner' do
      before(:each) do
        #create a raffle with 1 ticket
        r = prize.raffle
        r.tickets << create(:ticket)
      end

      it 'should return a Ticket' do
        prize.pick_winner.class.should == Ticket
      end

      it 'should be the Ticket we created in the before(:each) filter (since there is only 1)' do
        prize.pick_winner.should == prize.raffle.tickets.first
      end

      it 'should associate this Prize to the Ticket' do
        prize.ticket.should == nil
        tix = prize.pick_winner
        prize.reload
        prize.ticket.should == tix
      end

      it 'should never select the same ticket twice' do
        prize.raffle.tickets << create(:ticket)
        first_tix = prize.pick_winner
        prize.pick_winner.should_not == first_tix
      end
    end

    describe '#winner_selected?' do
      before(:each) do
        #create a raffle with 1 ticket
        r = prize.raffle
        r.tickets << create(:ticket)
      end

      it 'should be true for any prize that has a ticket associated with it' do
        prize.save!
        expect{ prize.pick_winner }.to change{ prize.winner_selected? }.from(false).to(true)
      end
    end
  end
end
