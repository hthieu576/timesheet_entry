require 'rails_helper'

RSpec.describe "timesheets/new", type: :view do
  before(:each) do
    assign(:timesheet, Timesheet.new())
  end

  it "renders new timesheet form" do
    render

    assert_select "form[action=?][method=?]", timesheets_path, "post" do
    end
  end
end
