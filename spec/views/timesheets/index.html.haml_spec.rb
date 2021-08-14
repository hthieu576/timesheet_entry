require 'rails_helper'

RSpec.describe "timesheets/index", type: :view do
  before(:each) do
    assign(:timesheets, [
      Timesheet.create!(),
      Timesheet.create!()
    ])
  end

  it "renders a list of timesheets" do
    render
  end
end
