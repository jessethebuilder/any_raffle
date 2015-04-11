class Prize < ActiveRecord::Base
  belongs_to :raffle

  has_one :ticket

  validates :raffle_id, presence: true

  validates :name, presence: true

  def pick_winner

  end
end
