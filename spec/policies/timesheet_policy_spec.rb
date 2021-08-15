require 'rails_helper'

RSpec.describe TimesheetPolicy, type: :policy do
  subject { described_class }

  let(:owner) { create(:user) }
  let(:timesheet_owner) { create(:timesheet, user: owner) }
  let(:timesheet_not_owner) { create(:timesheet) }

  permissions :update?, :edit?, :destroy?, :show? do
    it "denies access if timesheet not belong to owner" do
      expect(subject).not_to permit(owner, timesheet_not_owner)
    end

    it "grants access if timesheet belong to owner" do
      expect(subject).to permit(owner, timesheet_owner)
    end
  end
end
