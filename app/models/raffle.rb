class Raffle < ActiveRecord::Base
  include Bootsy::Container

  belongs_to :user

  has_many :tickets

  has_many :prizes
  accepts_nested_attributes_for :prizes, allow_destroy: true

  validates :description, presence: true

  validates :ticket_price, presence: true, numericality: {:greater_than_or_equal_to => 0}

  validates :ticket_max, :numericality => {:greater_than_or_equal_to => 1, :only_integer => true, :allow_blank => true}

  # validates :user_id, presence: true

  validate :ticket_max_or_end_time
  validate :end_time_is_in_future, :on => :create
  validate :active_raffle_validations

  #spec pending for this
  # validate :at_least_one_prize

  before_destroy :prevent_destroy_if_ticket_has_sold

  #FarmSlugs add presence validation its id_method
  use_farm_slugs id_method: :title

  mount_uploader :image, ImageUploader, dependent: :destroy

  def pick
   tickets.not_winners.sample
  end

  # def active?
  #
  # end

  def tickets_left
    ticket_max - tickets.count if ticket_max
  end

  private

  def prevent_destroy_if_ticket_has_sold
    self.tickets.count > 0 ? false : true
  end

  def ticket_max_or_end_time
    if ticket_max.blank? && end_time.blank?
      errors.add :end_time, "and/or total number of tickets to sell can't be blank"
    end
  end

  def end_time_is_in_future
    errors.add :end_time, "must be in the future" if end_time && end_time < Time.now
  end

  def active_raffle_validations
    if self.active?
      errors.add(:end_time, "can't be changed after a raffle has begun") if changed.include?('end_time')
      errors.add(:ticket_max, "can't be changed after a raffle has begun") if changed.include?('ticket_max')
    end
  end

  # def at_least_one_prize
  #   # errors.add(:prizes, "can't be blank") if self.prizes.count < 1
  # end
end
