class Raffle < ActiveRecord::Base
  belongs_to :user

  has_many :tickets

  has_many :prizes

  validates :title, presence: true

  validates :description, presence: true

  validates :ticket_price, presence: true, numericality: {:greater_than_or_equal_to => 0}

  use_farm_slugs id_method: :title

  def pick
   tickets.not_winners.sample
  end
end
