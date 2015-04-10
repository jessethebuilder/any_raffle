require 'rails_helper'

RSpec.describe "prizes/new", type: :view do
  before(:each) do
    assign(:prize, Prize.new(
      :ticket_id => 1,
      :name => "MyString",
      :description => "MyText",
      :value => 1.5,
      :cost => 1.5
    ))
  end

  it "renders new prize form" do
    render

    assert_select "form[action=?][method=?]", prizes_path, "post" do

      assert_select "input#prize_ticket_id[name=?]", "prize[ticket_id]"

      assert_select "input#prize_name[name=?]", "prize[name]"

      assert_select "textarea#prize_description[name=?]", "prize[description]"

      assert_select "input#prize_value[name=?]", "prize[value]"

      assert_select "input#prize_cost[name=?]", "prize[cost]"
    end
  end
end
