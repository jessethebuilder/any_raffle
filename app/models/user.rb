class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :raffles

  validates :terms_of_use, acceptance: true

  # validates :name, :presence => true

  # use_farm_slugs
end
