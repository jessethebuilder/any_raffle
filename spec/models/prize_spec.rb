require 'rails_helper'

RSpec.describe Prize, type: :model do
  describe 'Validations' do
    it{ should validate_presence_of :raffle_id }

    it{ should validate_presence_of :name }
  end

  describe 'Associations' do
    it{ should have_one :ticket }
    it{ should belong_to :raffle }
  end

end
