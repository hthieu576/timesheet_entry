require 'rails_helper'

RSpec.describe "timesheets/edit", type: :view do
  before(:each) do
    @timesheet = assign(:timesheet, Timesheet.create!())
  end

  it "renders the edit timesheet form" do
    render

    assert_select "form[action=?][method=?]", timesheet_path(@timesheet), "post" do
    end
  end
end
