class Raffle < ActiveRecord::Base
  include Bootsy::Container

  belongs_to :user

  has_many :tickets

  has_many :prizes
  accepts_nested_attributes_for :prizes, allow_destroy: true

  validates :description, presence: true

  validates :ticket_price, presence: true, numericality: {:greater_than_or_equal_to => 0}

  validates :ticket_max, :numericality => {:greater_than_or_equal_to => 1, :only_integer => true, :allow_blank => true}

  validates :user_id, presence: true

  validate :ticket_max_or_end_time
  validate :end_time_is_in_future, :on => :create
  validate :active_raffle_validations

  before_destroy :prevent_if_active

  #FarmSlugs add presence validation its id_method
  use_farm_slugs id_method: :title

  mount_uploader :image, ImageUploader, dependent: :destroy

  def pick
   tickets.not_winners.sample
  end

  def active?
    tickets.count > 0
  end

  private

  def prevent_if_active
    self.active? ? false : true
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
end
