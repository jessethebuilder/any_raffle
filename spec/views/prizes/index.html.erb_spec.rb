require 'rails_helper'

RSpec.describe "prizes/index", type: :view do
  before(:each) do
    assign(:prizes, [
      Prize.create!(
        :ticket_id => 1,
        :name => "Name",
        :description => "MyText",
        :value => 1.5,
        :cost => 1.5
      ),
      Prize.create!(
        :ticket_id => 1,
        :name => "Name",
        :description => "MyText",
        :value => 1.5,
        :cost => 1.5
      )
    ])
  end

  it "renders a list of prizes" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
