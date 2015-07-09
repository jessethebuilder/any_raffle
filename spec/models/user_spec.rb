require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it{ should validate_presence_of :email }
    it{ should validate_presence_of :password }
    it{ should validate_acceptance_of :terms_of_use }
    # it{ should validate_presence_of :name }
  end

  describe 'Associations' do
    it{ should have_many :raffles }
  end

  describe 'Attributes' do
    # describe ':terms_of_use' do
    #   it 'should not create User without acceptance' do
    #     test_pw = "!TEstPassword12345"
    #     u = User.new email: Faker::Internet.email, password: test_pw, password: test_pw
    #     u.valid?.should == false
    #     u.errors[:terms_of_use].count.should be_greater_than 0
    #   end
    # end
  end # Attributes
end
