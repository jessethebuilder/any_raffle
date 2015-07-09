require 'rails_helper'

RSpec.describe Raffle, type: :model do
  let(:raffle){ create :raffle }

  describe 'Validations' do
    it{ should validate_presence_of :title }
    # it{ should validate_presence_of :description }

    it{ should validate_presence_of :ticket_price }
    it{ should validate_numericality_of(:ticket_price).is_greater_than_or_equal_to(0) }

    it{ should validate_numericality_of(:ticket_max).is_greater_than_or_equal_to(1) }

    it 'should validate presence of at least one prize' do
      pending
      raffle.prizes.destroy_all
      raffle.valid?.should == false
      raffle.errors[:prizes].include?("can't be blank").should == true
    end

    describe ':end_time validations' do
      before(:each) do
        raffle.ticket_max = nil
      end

      it 'should be a parseable date' do
        # A non-parseable date will be rejected, because the db column is datetime.
        # This is a little hacky, but whatever right now.
        raffle.end_time = 'a'
        raffle.valid?.should == false

        raffle.end_time = (Time.now + Random.rand(1..10000).minutes).to_s
        raffle.valid?.should == true
      end

      specify 'on CREATE, should only accept a datetime AFTER now' do
        r = build(:raffle)
        r.end_time = Time.now.to_s
        r.valid?.should == false
        r.errors[:end_time].include?('must be in the future').should == true
      end

      specify 'on SAVE, will accept a datetime AFTER now' do
        # This is a contrived example to show that the Raffles can be saved with an end time before now
        r = build(:raffle)
        r.end_time = nil
        r.ticket_max = 1
        r.save!
        r.end_time = Time.now
        r.valid?.should == true
      end
    end

    it 'should validate that there is a :max_tickets or :end_time' do
      raffle.ticket_max = nil
      raffle.end_time = nil
      raffle.valid?.should == false
      raffle.errors.messages[:end_time].include?("and/or total number of tickets to sell can't be blank").should == true
    end

    describe 'Validations for an Active raffle' do
      specify '#end_time cannot be changed after an raffle is active' do
        raffle.end_time = Time.now + Random.rand(1..10000).hours
        raffle.valid?.should == true

        raffle.end_time = Time.now + Random.rand(1..10000).hours
        raffle.valid?.should == true

        raffle.active = true
        raffle.end_time = Time.now + Random.rand(1..10000).hours
        raffle.valid?.should == false
        raffle.errors[:end_time].include?("can't be changed after a raffle has begun").should == true
      end

      specify '#ticket_max cannot be changed after a raffle is active' do
        raffle.ticket_max = Random.rand(1..100000)
        raffle.valid?.should == true

        raffle.active = true
        raffle.ticket_max = Random.rand(1..10000)
        raffle.valid?.should == false
        raffle.errors[:ticket_max].include?("can't be changed after a raffle has begun")
      end

      specify 'A Raffle cannot be deleted, after a ticket has sold' do
        raffle.tickets << create(:ticket)
        raffle.destroy
        raffle.destroyed?.should == false
      end
    end
  end #Validations

  describe 'Associations' do
    it{ should belong_to :user }

    it{ should have_many :tickets }

    it{ should have_many :prizes }
  end

  describe 'Methods' do
    let(:ticket){ build :ticket }

    describe '#pick' do
      before(:each) do
        raffle.tickets << ticket
      end

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
    end #pick

    describe '#tickets_left' do
      it 'should return the number of tickets left' do
        raffle.ticket_max = 100
        raffle.tickets << create(:ticket)
        raffle.tickets_left.should == 99
      end

      it 'should return nil if no ticket_max is specified' do
        raf = create(:raffle_with_end_time)
        raf.tickets_left.should == nil
      end
    end #tickets_left
  end #Methods

  describe 'Attributes' do
    describe ':active' do
      it 'should default to false' do
        raffle.active.should == false
        raffle.active.should_not == nil
      end




    end
  end #Attributes

end
