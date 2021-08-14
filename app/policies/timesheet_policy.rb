class TimesheetPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def edit
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end
