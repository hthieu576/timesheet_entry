class TimesheetDecorator < Draper::Decorator
  delegate_all

  def data_of_entry
    "#{object.date}: #{timesheet_format(object.start_time)} - #{timesheet_format(object.finish_time)} #{amount}"
  end

  def amount
    "$#{object.earning_daily(object.date, timesheet_format(object.start_time), timesheet_format(object.finish_time)).round(2)}"
  end

  private

  def timesheet_format(time)
    l(time, format:  '%H:%M')
  end
end
