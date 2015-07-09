require 'rails_helper'

describe 'Login Form Request', type: :feature, js: true do
  context 'Logging in an existing user' do
    before(:each) do
      visit '/'
    end

    it 'should have Login in #top_nav' do
      within('#top_nav'){ page.should have_link 'Login' }
    end

    specify 'clicking "login" should open a modal with a login form' do
      page.should_not have_css('#new_user_session')
      within('#top_nav'){ click_link 'Login' }
      within('#express_modal'){ page.should have_css('#new_user_session') }
    end

    specify 'opening the login form and clicking close should destroy the modal' do
      within('#top_nav'){ click_link 'Login' }
      within('#express_modal'){ find('.close').click }
      page.should_not have_css('#express_modal')
    end

    context 'Logging in the User' do
      let(:test_pw){ 'k3kn!!TEStPass99334677' }
      let!(:user){ create :user, password: test_pw }

      def user_min
        within('#top_nav'){ click_link 'Login' }
        within('#new_user_session') do
          fill_in 'Email', with: user.email
          fill_in 'Password', with: test_pw
        end
      end

      def login
        user_min
        click_button 'Login'
      end

      it 'should login the user' do
        within('#top_nav'){ page.should have_link 'Login' }
        login
        within('#top_nav'){ page.should have_link 'Logout' }
      end

      specify 'after login, it should hide #new_user and show #user_dashboard' do
        within('#home_block_1'){ page.should have_css('#new_user') }
        login
        within('#home_block_1'){ page.should have_css('#user_dashboard') }
      end

      specify 'after login, it should close the modal' do
        login
        page.should_not have_css('#express_modal')
      end

      specify 'user should be able to login, logout, and log back in' do
        login
        within('#top_nav'){ click_link 'Logout' }
        login
        within('#top_nav'){ page.should have_link 'Logout' }
      end
    end
  end # Logging in an existing user
end