require 'rails_helper'

RSpec.describe "prizes/show", type: :view do
  before(:each) do
    @prize = assign(:prize, Prize.create!(
      :ticket_id => 1,
      :name => "Name",
      :description => "MyText",
      :value => 1.5,
      :cost => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
  end
end
