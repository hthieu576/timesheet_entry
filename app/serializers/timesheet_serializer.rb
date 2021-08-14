# == Schema Information
#
# Table name: timesheets
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  date        :date             not null
#  start_time  :time             not null
#  finish_time :time             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class TimesheetSerializer < ActiveModel::Serializer
  attributes :id, :date, :start_time, :finish_time
end
