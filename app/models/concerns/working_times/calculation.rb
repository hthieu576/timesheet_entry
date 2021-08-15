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
      start_time =  start_time.is_a?(String) ? Time.parse(start_time) : Time.parse(start_time.strftime('%H:%M'))
      finish_time = finish_time.is_a?(String) ? Time.parse(finish_time) : Time.parse(finish_time.strftime('%H:%M'))
      schedule_working = WORKING_HOURS_SCHEDULE[date.wday]
      range_time_working = Time.parse(schedule_working[:start_time])..Time.parse(schedule_working[:finish_time])
      if range_time_working.include?(start_time..finish_time)
        ((finish_time - start_time) / 1.hours) * schedule_working[:rate]
      elsif (start_time..finish_time).include?(range_time_working)
        total_hours = (finish_time - start_time) / 1.hours
        hours_inside_rate = (Time.parse(schedule_working[:finish_time]) - Time.parse(schedule_working[:start_time])) / 1.hours
        hours_outside_rate = total_hours - hours_inside_rate
        hours_inside_rate * schedule_working[:rate] + hours_outside_rate * schedule_working[:outside_rate]
      elsif finish_time < Time.parse(schedule_working[:start_time]) || start_time > Time.parse(schedule_working[:finish_time])
        ((finish_time - start_time) / 1.hours) * schedule_working[:outside_rate]
      elsif range_time_working.exclude?(start_time) && range_time_working.include?(finish_time)
        total_hours = (finish_time - start_time) / 1.hours
        hours_inside_rate = (finish_time - Time.parse(schedule_working[:start_time])) / 1.hours
        hours_outside_rate = total_hours - hours_inside_rate
        hours_inside_rate * schedule_working[:rate] + hours_outside_rate * schedule_working[:outside_rate]
      elsif range_time_working.include?(start_time) && range_time_working.exclude?(finish_time)
        total_hours = (finish_time - start_time) / 1.hours
        hours_inside_rate = (Time.parse(schedule_working[:finish_time]) - start_time) / 1.hours
        hours_outside_rate = total_hours - hours_inside_rate
        hours_inside_rate * schedule_working[:rate] + hours_outside_rate * schedule_working[:outside_rate]
      else
        0                    
      end
    end
  end
end