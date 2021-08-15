# frozen_string_literal: true

module WorkingTimes
  module Calculation
    extend ActiveSupport::Concern

    WORKING_HOURS_SCHEDULE = {
      1 => { start_time: '07:00', finish_time: '19:00', rate: 22, outside_rate: 34 },
      2 => { start_time: '05:00', finish_time: '17:00', rate: 25, outside_rate: 35 },
      3 => { start_time: '07:00', finish_time: '19:00', rate: 22, outside_rate: 34 },
      4 => { start_time: '05:00', finish_time: '17:00', rate: 25, outside_rate: 35 },
      5 => { start_time: '07:00', finish_time: '19:00', rate: 22, outside_rate: 34 },
      6 => { start_time: '00:00', finish_time: '23:59', rate: 47, outside_rate: 47 },
      0 => { start_time: '00:00', finish_time: '23:59', rate: 47, outside_rate: 47 },
    }

    def earning_daily(date, start_time, finish_time)
      start_time =  standard_format_time(start_time)
      finish_time = standard_format_time(finish_time)

      schedule_working = WORKING_HOURS_SCHEDULE[date.wday]
      range_time_working = Time.parse(schedule_working[:start_time])..Time.parse(schedule_working[:finish_time])

      if range_time_working.include?(start_time..finish_time)
        total_hours(start_time, finish_time) * schedule_working[:rate]
      elsif (start_time..finish_time).include?(range_time_working)
        hours_inside_rate = (Time.parse(schedule_working[:finish_time]) - Time.parse(schedule_working[:start_time])) / 1.hours
        calculating_amount!(total_hours(start_time, finish_time), hours_inside_rate, schedule_working)
      elsif finish_time < Time.parse(schedule_working[:start_time]) || start_time > Time.parse(schedule_working[:finish_time])
        total_hours(start_time, finish_time) * schedule_working[:outside_rate]
      elsif range_time_working.exclude?(start_time) && range_time_working.include?(finish_time)
        hours_inside_rate = (finish_time - Time.parse(schedule_working[:start_time])) / 1.hours
        calculating_amount!(total_hours(start_time, finish_time), hours_inside_rate, schedule_working)
      elsif range_time_working.include?(start_time) && range_time_working.exclude?(finish_time)
        hours_inside_rate = (Time.parse(schedule_working[:finish_time]) - start_time) / 1.hours
        calculating_amount!(total_hours(start_time, finish_time), hours_inside_rate, schedule_working)
      else
        0                    
      end
    end

    private

    def standard_format_time(time)
      time.is_a?(String) ? Time.parse(time) : Time.parse(time.strftime('%H:%M'))
    end

    def total_hours(start_time, finish_time)
      (finish_time - start_time) / 1.hours
    end

    def calculating_amount!(total_hours, hours_inside_rate, schedule_working)
      hours_outside_rate = total_hours - hours_inside_rate
      hours_inside_rate * schedule_working[:rate] + hours_outside_rate * schedule_working[:outside_rate]
    end
  end
end