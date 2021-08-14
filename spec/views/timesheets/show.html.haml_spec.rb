require 'rails_helper'

RSpec.describe "timesheets/show", type: :view do
  before(:each) do
    @timesheet = assign(:timesheet, Timesheet.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
