require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:ticket){ build :ticket }

  describe 'Validations' do
    it{ should validate_presence_of :email }
    it{ should validate_presence_of :raffle_id }
  end

  describe 'Associations' do
    it{ should belong_to :raffle }

    it{ should belong_to :prize }
  end

  describe 'Methods' do
    describe '#winner?' do
      specify 'A new Ticket should not be a winner' do
        Ticket.new.winner?.should == false
      end
    end

    describe '#price' do
      it 'should return :ticket_price of the associated raffle' do
        ticket.price.should == ticket.raffle.ticket_price
      end
    end
  end

  describe 'Idioms' do
    specify 'Default value for winner should be false' do
      Ticket.new.winner?.should == false
    end

    specify 'Tickets cannot be destroyed' do
      ticket.save!
      # ticket.destroy.should == false
      ticket.destroyed?.should == false
    end
  end

  describe 'Class Methods' do
    describe 'Scopes' do
      let!(:winning_ticket){ create :winning_ticket }
      before(:each) do
        ticket.save!
      end

      describe 'And Prizes' do
        it 'should return a join table of tickets and prices' do

        end

        it 'should not return tickets that are not in the scope' do

        end
      end

      describe 'Winners' do
        it 'should return only winners' do
          Ticket.winners.count.should == 1
          Ticket.winners.first.winner?.should == true
        end

        it 'should return only those tickets on a raffle, when called from association' do
          r = create :raffle
          w = create :winning_ticket
          r.tickets << w

          r.tickets.winners.first.should == w
        end

      end

      describe '#not_winners' do
        it 'should return tickets that have not won yet' do
          Ticket.not_winners.count.should == 1
          Ticket.not_winners.first.should == ticket
        end
      end


      it 'should return only those tickets on a raffle, when called from association' do
        r = create :raffle
        t = create :ticket
        r.tickets << t

        r.tickets.not_winners.count.should == 1
        r.tickets.not_winners.first.should == t
      end

    end
  end
end
