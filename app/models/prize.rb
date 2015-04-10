class Prize < ActiveRecord::Base
  belongs_to :raffle
  belongs_to :ticket

  validates :raffle_id, presence: true

  validates :name, presence: true
end
