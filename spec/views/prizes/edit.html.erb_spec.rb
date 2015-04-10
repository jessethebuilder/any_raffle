require 'rails_helper'

RSpec.describe "prizes/edit", type: :view do
  before(:each) do
    @prize = assign(:prize, Prize.create!(
      :ticket_id => 1,
      :name => "MyString",
      :description => "MyText",
      :value => 1.5,
      :cost => 1.5
    ))
  end

  it "renders the edit prize form" do
    render

    assert_select "form[action=?][method=?]", prize_path(@prize), "post" do

      assert_select "input#prize_ticket_id[name=?]", "prize[ticket_id]"

      assert_select "input#prize_name[name=?]", "prize[name]"

      assert_select "textarea#prize_description[name=?]", "prize[description]"

      assert_select "input#prize_value[name=?]", "prize[value]"

      assert_select "input#prize_cost[name=?]", "prize[cost]"
    end
  end
end
