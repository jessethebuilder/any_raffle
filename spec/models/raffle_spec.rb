require 'rails_helper'

RSpec.describe Raffle, type: :model do
  let(:raffle){ create :raffle }

  describe 'Validations' do
    it{ should validate_presence_of :title }
    it{ should validate_presence_of :description }

    it{ should validate_presence_of :ticket_price }
    it{ should validate_numericality_of(:ticket_price).is_greater_than_or_equal_to(0) }
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

      it 'returned ticket should be saved as a winner' do
        raffle.pick.winner.should == true
      end

      it 'should not return a ticket that has already marked as a winner' do
        winning_ticket = build :ticket
        winning_ticket.winner = true
        winning_ticket.save

        #since there is 2 tickets, and one is already a winner, the other ticket will be picked
        raffle.pick.should == ticket
      end

      it 'should return nil if all tickets are winners' do
        raffle.pick.should == ticket

        #no tickets left
        raffle.pick.should == nil
      end
    end
  end #Methods


end
