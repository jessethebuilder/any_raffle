require 'rails_helper'

RSpec.describe Raffle, type: :model do
  let(:raffle){ create :raffle }

  describe 'Validations' do
    it{ should validate_presence_of :title }
    it{ should validate_presence_of :description }

    it{ should validate_presence_of :ticket_price }
    it{ should validate_numericality_of(:ticket_price).is_greater_than_or_equal_to(0) }

    it{ should validate_numericality_of(:ticket_max).is_greater_than_or_equal_to(1) }

    describe ':end_time validations' do
      before(:each) do
        raffle.ticket_max = nil
      end

      it 'should be a parseable date' do
        # A non-parseable date will be rejected, because the db column is datetime.
        # This is a little hacky, but whatever right now.

      end
    end

    it 'should validate that there is a :max_tickets or :end_time' do
      raffle.ticket_max = nil
      raffle.end_time = nil
      raffle.valid?.should == false
      raffle.errors.messages[:end_time].include?("and/or total number of tickets to sell can't be blank").should == true
    end
  end

  describe 'Associations' do
    it{ should belong_to :user }

    it{ should have_many :tickets }

    it{ should have_many :prizes }
  end

  describe 'Methods' do
    let(:ticket){ build :ticket }

    before(:each) do
      raffle.tickets << ticket
    end

    describe '#pick' do
      it 'should return a ticket' do
        raffle.pick.class.should == Ticket
      end

      it 'should not return a ticket that has already marked as a winner' do
        create(:winning_ticket)
        #since there is 2 tickets, and one is already a winner, the other ticket will be picked
        raffle.pick.should == ticket
      end

      it 'should return nil if all tickets are winners' do
        ticket.prize = create(:prize)
        ticket.save!
        #no tickets left
        raffle.pick.should == nil
      end
    end
  end #Methods


end
