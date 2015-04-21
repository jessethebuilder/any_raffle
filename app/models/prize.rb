class Prize < ActiveRecord::Base
  belongs_to :raffle

  has_one :ticket

  validates :raffle_id, presence: true

  validates :name, presence: true

  before_destroy do
    self.raffle.active? ? false : true
  end

  def pick_winner
    self.ticket = raffle.pick
    self.save
    self.ticket
  end

  def winner_selected?
    Ticket.where(:prize_id => id).first ? true : false
  end
end
