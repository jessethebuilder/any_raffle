class Ticket < ActiveRecord::Base
  belongs_to :raffle

  validates :raffle_id, presence: true

  validates :email, presence: true

  scope :winners, -> { where(winner: true) }
  scope :not_winners, -> { where(winner: false) }
end
