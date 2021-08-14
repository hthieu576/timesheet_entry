class TimesheetDecorator < Draper::Decorator
  delegate_all

  def data_of_entry
    "#{object.date}: #{l(object.start_time, format:  '%H:%M')} - #{l(object.finish_time, format:  '%H:%M')} #{amount}"
  end

  def amount
    "$#{object.earning_daily(object.date, object.start_time, object.finish_time).round(2)}"
  end
end
