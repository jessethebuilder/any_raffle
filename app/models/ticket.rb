class Ticket < ActiveRecord::Base
  belongs_to :raffle

  belongs_to :prize

  validates :raffle_id, presence: true

  validates :email, presence: true

  before_destroy do
    false
  end

  scope :winners, -> { where.not(prize_id: nil) }
  scope :not_winners, -> { where(prize_id: nil) }

  def winner?
    not self.prize.nil?
  end

  def price
    raffle.ticket_price
  end
end
