require 'rails_helper'

describe 'Home Page Requests', type: :feature, js: true do
  before(:each) do
    visit '/'
  end

end