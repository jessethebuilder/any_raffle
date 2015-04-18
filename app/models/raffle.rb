class Raffle < ActiveRecord::Base
  belongs_to :user

  has_many :tickets

  has_many :prizes
  accepts_nested_attributes_for :prizes, allow_destroy: true

  validates :description, presence: true

  validates :ticket_price, presence: true, numericality: {:greater_than_or_equal_to => 0}

  validates :ticket_max, :numericality => {:greater_than_or_equal_to => 1, :only_integer => true, :allow_blank => true}

  validate :ticket_max_or_end_time

  use_farm_slugs id_method: :title

  mount_uploader :image, ImageUploader, dependent: :destroy

  def pick
   tickets.not_winners.sample
  end

  private

  def ticket_max_or_end_time
    if ticket_max.blank? && end_time.blank?
      errors.add :end_time, "and/or total number of tickets to sell can't be blank"
    end
  end
end
